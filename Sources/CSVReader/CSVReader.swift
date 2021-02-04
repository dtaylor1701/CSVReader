import Foundation

public enum CSVError: Error {
    case emptyFile
}

public final class CSVReader {
    public func read(_ file: URL, includesHeaders: Bool = true) throws -> CSVData {
        let content = try String(contentsOf: file)
        let rows = content.split(separator: "\n")

        if rows.count == 0 {
            throw CSVError.emptyFile
        }

        var headers: [String]? = nil
        if includesHeaders {
            headers = rows[0].commaSeparatedValues()
        }

        let start = includesHeaders ? 1 : 0

        var values: [[String]] = []
        for index in start..<rows.count {
            let rowValues = rows[index].commaSeparatedValues()
            values.append(rowValues)
        }

        return CSVData(headers: headers, values: values)
    }
}

extension String.SubSequence {
    func commaSeparatedValues() -> [String] {
        return self.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
    }
}

public struct CSVData {
    public let headers: [String]?
    public let values: [[String]]

    public init(headers: [String]?, values: [[String]]) {
        self.headers = headers
        self.values = values
    }

    public func value(ofColumnWithHeader header: String, onLine lineIndex: Int) -> String? {
        guard let columnIndex = headers?.firstIndex(of: header) else {
            return nil
        }

        return values[lineIndex][columnIndex]
    }
}
