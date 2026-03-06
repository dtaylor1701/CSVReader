import Testing
import Foundation
@testable import CSVReader

@Suite("CSVReader Tests")
struct CSVReaderTests {

    let reader = CSVReader()

    @Test func readFileWithHeaders() throws {
        guard let file = Bundle.module.url(forResource: "Resources/Test", withExtension: "csv")
          else { fatalError() }
        let data = try reader.read(file)

        #expect(data.headers?.count == 3)
        #expect(data.values.count == 4)

        #expect(data.headers == ["Header 1", "Header 2", "Header 3"])

        #expect(data.value(ofColumnWithHeader: "Header 2", onLine: 2) == "7")
    }

    @Test func readFileWithoutHeaders() throws {
        guard let file = Bundle.module.url(forResource: "Resources/Test", withExtension: "csv")
          else { fatalError() }
        let data = try reader.read(file, includesHeaders: false)

        #expect(data.headers == nil)
        #expect(data.values.count == 5)

        #expect(data.values[3][1] == "7")
    }
} 
