import XCTest
import Foundation
@testable import CSVReader

final class CSVReaderTests: XCTestCase {

    var reader: CSVReader!

    override func setUpWithError() throws {
        reader = CSVReader()
    }

    override func tearDownWithError() throws {
        reader = nil
    }

    func testReadFileWithHeaders() throws {
        guard let file = Bundle.module.url(forResource: "Resources/Test", withExtension: "csv")
          else { fatalError() }
        let data = try reader.read(file: file)

        XCTAssertEqual(data.headers?.count, 3)
        XCTAssertEqual(data.values.count, 4)

        XCTAssertEqual(data.headers, ["Header 1", "Header 2", "Header 3"])

        XCTAssertEqual(data.value(ofColumnWithHeader: "Header 2", atIndex: 2), "7")
    }

    func testReadFileWithoutHeaders() throws {
        guard let file = Bundle.module.url(forResource: "Resources/Test", withExtension: "csv")
          else { fatalError() }
        let data = try reader.read(file: file, includesHeaders: false)

        XCTAssertNil(data.headers)
        XCTAssertEqual(data.values.count, 5)

        XCTAssertEqual(data.values[3][1], "7")
    }

    static var allTests = [
        ("testExample", testReadFileWithHeaders),
    ]
} 
