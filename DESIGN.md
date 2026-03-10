# CSVReader Design Documentation

## 1. High-Level Architecture
`CSVReader` is a lightweight, synchronous Swift library designed for parsing Comma-Separated Values (CSV) files. The architecture follows a simple "Reader-Data" pattern:
- **`CSVReader`**: The engine responsible for file I/O and parsing logic.
- **`CSVData`**: A value-type container that holds the parsed results, providing structured access to the data.

The system is designed to be stateless; each `read` operation is independent and returns a fresh `CSVData` object.

## 2. Core Design Philosophies & Patterns
- **Simplicity & Ease of Use**: The API is minimal, requiring only a file URL to produce a usable data structure.
- **Immutability**: Parsed data is stored in an immutable `struct` (`CSVData`), ensuring thread safety and predictable behavior once the parsing is complete.
- **Protocol-Oriented Extensions**: Internal parsing logic for individual rows is encapsulated within a `String.SubSequence` extension to keep the core `CSVReader` class clean and focused on file-level coordination.
- **Error Safety**: Instead of returning optionals for critical failures, the library uses Swift's `Error` handling to signal specific issues like empty files.

## 3. Technical Environment
- **Language**: Swift 5.3+
- **Build System**: Swift Package Manager (SPM) & Xcode Project (`.xcodeproj`).
- **Dependency Management**: Zero external dependencies to maintain a small binary footprint and eliminate supply-chain risks.
- **Platforms**: iOS 12.0+, macOS 10.13+, tvOS 12.0+, watchOS 4.0+.

## 4. Data Models & Relationships
### `CSVData` (Struct)
- **`headers: [String]?`**: Stores the optional header row.
- **`values: [[String]]`**: A 2D array representing rows and columns.
- **Relationship**: `CSVData` provides a mapping between `headers` and `values` through its `value(ofColumnWithHeader:onLine:)` method, allowing for O(1) header lookup and O(1) row access.

## 5. Key Components & API
### Internal Components
- **Line Splitter**: Uses `split(separator: "\n")` to tokenize rows.
- **Value Parser**: Uses a custom extension on `String.SubSequence` to split by commas and trim whitespace/newlines.

### External API
- **`CSVReader.read(_:includesHeaders:)`**: The primary entry point. It accepts a `URL` and an optional boolean flag to toggle header parsing.
- **`CSVData.value(ofColumnWithHeader:onLine:)`**: A convenience method for accessing data by header name rather than index.

## 6. Technical Specifications
- **Error Handling**: Defines `CSVError.emptyFile` for scenarios where a file exists but contains no parseable rows.
- **Concurrency Model**: The current implementation is synchronous and blocking. It relies on the caller to dispatch to a background queue (e.g., GCD or Swift Concurrency) if parsing large files on the main thread.
- **State Management**: The library is stateless. All configuration is passed per-call via the `read` method.

## 7. Testing Infrastructure
- **Framework**: Swift Testing (utilizing `@Suite` and `@Test` attributes).
- **Strategy**:
    - **Unit Testing**: Validates parsing logic for files with and without headers.
    - **Resource-Based Testing**: Uses a physical `Test.csv` file bundled within the test target to ensure real-world file I/O and encoding are handled correctly.
- **Validation**: Asserts on row counts, header equality, and specific cell value retrieval.

## 8. Considerations
- **Security**: The library uses `String(contentsOf:)`, which is suitable for local files. 
- **Performance**:
    - **Memory**: The entire file is loaded into memory as a `String`. For extremely large CSVs (hundreds of MBs), a stream-based approach would be a future optimization.
    - **Parsing**: Whitespace trimming is performed on every cell during parsing to ensure data cleanliness.
- **Scalability**: While optimized for small to medium CSV files, the 2D array structure allows for efficient indexing. Large-scale datasets may benefit from future lazy-loading or row-by-row iteration features.
