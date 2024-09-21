//
//  ehmTests.swift
//  ehmTests
//
//  Created by Gianlo Personal on 29.01.23.
//

import XCTest
@testable import ehm

final class ehmTests: XCTestCase {

    func testTimeEntryJSONDecoder() throws {
        let decoder = JSONDecoder()
        let timeEntry = try decoder.decode(RedmineTimeEntry.self, from: testFeature_te01)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        XCTAssertEqual(timeEntry.id, 163582)
        XCTAssertEqual(timeEntry.project.name, "renovero")
        XCTAssertEqual(timeEntry.activity.name, "Entwicklung")
        XCTAssertEqual(timeEntry.hours, 2.67)
        XCTAssertEqual(timeEntry.comment, "REN-4021")
        XCTAssertEqual(timeEntry.date, dateFormatter.date(from: "2023-01-27"))
    }
    
    func testTimeEntriesResultJSONDecoder() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let result = try decoder.decode(RedmineTimeEntriesResult.self, from: testFeature_te02)
        
        XCTAssertEqual(result.entries.count, 2)
        XCTAssertEqual(result.totalCount, 369)
        XCTAssertEqual(result.limit, 2)
        XCTAssertEqual(result.offset, 10)
        
        XCTAssertEqual(result.entries[0].id, 163582)
        XCTAssertEqual(result.entries[1].id, 163581)
    }
    
    func testHTTPClientFetchTimeEntries() async throws {
        let fakeDownloader = FakeRedmineDownloader()
        let client = RedmineHTTPClient(downloader: fakeDownloader)
        let timeEntries = try await client.timeEntries
        
        XCTAssertEqual(timeEntries.count, 2)
    }
}
