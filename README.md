# CSVReader

CSVReader is a lightweight and easy-to-use Swift library for parsing CSV (Comma-Separated Values) files. It provides a simple API to read CSV content from a file URL and access the data either by header names or direct indexing.

## Features

- **Header Support**: Automatically extract headers from the first row or parse files without headers.
- **Structured Data**: Access your data through the `CSVData` model, which provides convenient methods for retrieving specific values.
- **Trimming**: Automatically trims whitespace and newlines from parsed values.
- **Error Handling**: Throws clear errors for common issues like empty files.

## Installation

### Swift Package Manager

To integrate `CSVReader` into your Swift project, add it to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/your-repo/CSVReader.git", from: "1.0.0")
]
```

Then, add `CSVReader` to your target's dependencies:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["CSVReader"]),
]
```

## Usage

### Basic Example

```swift
import Foundation
import CSVReader

let reader = CSVReader()
let fileURL = URL(fileURLWithPath: "path/to/your/file.csv")

do {
    // Read CSV with headers (default)
    let data = try reader.read(fileURL)

    // Access headers
    if let headers = data.headers {
        print("Headers: \(headers)")
    }

    // Access a value by header and line index
    if let value = data.value(ofColumnWithHeader: "Email", onLine: 0) {
        print("First user's email: \(value)")
    }

    // Access raw values directly
    let firstRow = data.values[0]
    print("First row raw data: \(firstRow)")

} catch CSVError.emptyFile {
    print("The CSV file is empty.")
} catch {
    print("An error occurred: \(error)")
}
```

### Reading Without Headers

If your CSV file does not contain a header row, you can specify `includesHeaders: false`:

```swift
let data = try reader.read(fileURL, includesHeaders: false)
print("Data count: \(data.values.count)")
```

## API Reference

### `CSVReader`

The primary class for reading CSV files.

- `read(_ file: URL, includesHeaders: Bool = true) throws -> CSVData`: Parses the file at the given URL.

### `CSVData`

The container for parsed CSV information.

- `headers: [String]?`: An array of strings representing the CSV headers.
- `values: [[String]]`: A 2D array of strings containing the row and column data.
- `value(ofColumnWithHeader header: String, onLine lineIndex: Int) -> String?`: Retrieves a value for a specific header name at a given row index.

### `CSVError`

- `emptyFile`: Thrown when the reader attempts to parse a file with no content.

## Requirements

- Swift 5.3+
- iOS 12.0+ / macOS 10.13+ / tvOS 12.0+ / watchOS 4.0+

## License

This project is available under the MIT license. See the LICENSE file for more info.
