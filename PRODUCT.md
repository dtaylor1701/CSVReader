# PRODUCT.md - CSVReader

## Product Vision & Core Objectives
**Vision:** To provide the Swift developer community with the most intuitive, lightweight, and reliable CSV parsing library that "just works" without the overhead of heavy dependencies or complex configurations.

**Core Objectives:**
*   **Zero Friction:** Enable developers to go from a file URL to structured data in under three lines of code.
*   **Type-Safe Exploration:** Provide a structured `CSVData` model that reduces runtime errors when accessing row and column data.
*   **Performance & Footprint:** Maintain a minimal binary size and prioritize efficient parsing for mobile and desktop environments.

**The Problem:**
Native Swift string manipulation is powerful but parsing CSVs manually often leads to "boilerplate fatigue"—handling headers, trimming whitespace, and managing 2D arrays. Existing solutions are often bloated, outdated, or require complex setups. `CSVReader` solves this by offering a focused, modern Swift API for the 80% of use cases involving standard CSV data.

---

## Target Audience & User Personas
`CSVReader` is designed for Swift developers across all Apple platforms (iOS, macOS, tvOS, watchOS) and Server-Side Swift.

### User Personas:
*   **The App Developer (e.g., Sarah):** Building an iOS app that needs to import a local configuration file or allow users to upload their own data spreadsheets. She values simplicity and a tiny library footprint.
*   **The Data Scripting Engineer (e.g., Alex):** Using Swift for quick data processing or automation tasks. He needs a reliable way to read CSVs without worrying about encoding or row-splitting edge cases.
*   **The Framework Author:** Building a larger data-science or visualization library and needs a robust, zero-dependency CSV parser as a foundational component.

---

## Feature Roadmap

### Short-Term (V1.1 - V1.2)
*   **Custom Delimiters:** Support for Tab-Separated (TSV) or Semicolon-separated values.
*   **Swift Concurrency:** Native `async/await` support for non-blocking file reads.
*   **Enhanced Error Context:** Provide line and column numbers in `CSVError` for easier debugging of malformed files.

### Medium-Term (V1.5 - V2.0)
*   **RFC 4180 Compliance:** Full support for escaped quotes and multi-line fields.
*   **Stream-Based Parsing:** Implement a lazy-loading "iterator" pattern to handle multi-gigabyte files without loading the entire content into memory.
*   **Codable Integration:** Automatically map CSV rows to Swift `Decodable` structs for seamless data modeling.

### Long-Term (V3.0+)
*   **CSV Writing:** Expand the library into `CSVToolkit` to support generating and exporting CSV files.
*   **Localization Support:** Smart handling of locale-specific decimal separators and date formats.
*   **Linux/Server Optimization:** Tailored performance tuning for high-throughput processing on Swift-on-Linux.

---

## Feature Prioritization
We prioritize features based on the **"Developer Happiness"** index:
1.  **Correctness:** If a CSV doesn't parse correctly, nothing else matters. RFC 4180 compliance is our next major milestone.
2.  **Ergonomics:** API calls must feel "Swifty." This is why Codable support is prioritized over complex writing features.
3.  **Performance:** While we aim for speed, we will not sacrifice API clarity for micro-optimizations unless dealing with large-scale data (the driver for Stream-based parsing).

---

## Iteration Strategy
Our development cycle is driven by **Empirical Feedback** and **Performance Benchmarking**:
*   **Community Feedback:** We monitor GitHub issues and discussions to identify common "rough edges" in the API.
*   **Profiling:** Every major release includes a performance audit using Instruments to ensure parsing logic remains lean.
*   **Unit Testing:** We maintain high code coverage, ensuring that every edge case (empty rows, trailing commas) is verified before a release.

---

## Release Strategy & Onboarding
*   **Semantic Versioning:** We strictly adhere to `Major.Minor.Patch` to ensure dependency stability for our users via Swift Package Manager.
*   **Zero-Config Onboarding:** The `README.md` will always feature a "Copy-Paste-Run" example. Our goal is for a developer to understand the library's utility within 30 seconds of landing on the repository.
*   **Documentation:** Every public method is documented with DocC-compatible comments, providing inline help directly within Xcode.

---

## Success Metrics & KPIs
*   **Adoption Rate:** Monthly growth in GitHub stars and clones.
*   **Quality Index:** Ratio of closed-to-open issues and maintaining 90%+ code coverage.
*   **Engagement:** Number of third-party projects listing `CSVReader` as a dependency in their `Package.swift`.
*   **Performance:** Maintaining sub-100ms parsing times for 10,000-row standard CSV files on baseline iOS hardware.

---

## Future Opportunities
*   **Data Visualization Plugins:** Extensions to export `CSVData` directly into popular Swift charting libraries.
*   **Excel Integration:** Potential to bridge with libraries that handle `.xlsx` files, positioning `CSVReader` as the gateway for spreadsheet data in Swift.
*   **Interactive CLI Tool:** A companion command-line interface for inspecting and validating CSV files directly from the terminal.
