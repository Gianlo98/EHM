//
//  TimeEntriesProvider.swift
//  ehmTests
//
//  Created by Gianlo Personal on 29.01.23.
//

import Foundation
import OSLog

@MainActor
class RedmineTimeEntriesProvider: ObservableObject {
    @Published var timeEntries: [RedmineTimeEntry] = []
    @Published var groupedTimeEntries: [GroupedTimeEntry] = []
    @Published var summedTimeEntries: [GroupedTimeEntry] = []
    
    @Published var dateFrom: Date
    @Published var dateTo: Date
    
    var client: RedmineHTTPClient
    
    func fetchTimeEntries() async throws {
        Logger.providerLogger.debug("[RedmineTimeEntriesProvider] Fetching entries")

        let fetchedEntries = try await client.timeEntries
        self.timeEntries = fetchedEntries
        self.groupedTimeEntries = groupTimeEntries(ungroupedTimeEntries: fetchedEntries)
        self.summedTimeEntries = summedTimeEntries(ungroupedTimeEntries: fetchedEntries)
    }
    
    func fetchCurrentUser() async throws -> RedmineCurrentUser {
        return try await client.currentUser
    }
    
    convenience init(client: RedmineHTTPClient? = nil) {
        if let passedClient = client {
            self.init(dateFrom: Date.now.startOfMonth(), dateTo: Date.now.endOfMonth(), client: passedClient)
        } else {
            let resolvedClient = RedmineHTTPClient(dateFrom: Date.now.startOfMonth(), dateTo: Date.now.endOfMonth())
            self.init(dateFrom: Date.now.startOfMonth(), dateTo: Date.now.endOfMonth(), client: resolvedClient)
        }
    }
    
    init(dateFrom: Date, dateTo: Date, client: RedmineHTTPClient) {
        self.client = client
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }
    
    func groupTimeEntries(ungroupedTimeEntries: [RedmineTimeEntry]) -> [GroupedTimeEntry] {
        let dict = Dictionary(grouping: ungroupedTimeEntries, by: \.date)
        
        return dict.mapValues { timeEntries in
            timeEntries.reduce(0) { $0 + $1.hours }
        }.map { key, value in
            GroupedTimeEntry(date: key, value: value)
        }.sorted(by: {$0.date.compare($1.date) == .orderedAscending})
    }
    
    func summedTimeEntries(ungroupedTimeEntries: [RedmineTimeEntry]) -> [GroupedTimeEntry] {
        let dict = Dictionary(grouping: ungroupedTimeEntries) { s in
            s.date
        }
        
        let sortedDates = dict.sorted(by: {$0.key.compare($1.key) == .orderedAscending})
        
        var absVal = 0.0
        let chartData = sortedDates.map { (key, value) in
            absVal += value.reduce(0) { $0 + $1.hours }
            return GroupedTimeEntry(date: key, value: absVal)
        }

        return chartData
    }
    
    func setDateFrom(date: Date) async throws {
        self.dateFrom = date
//        self.client = RedmineHTTPClient(dateFrom: self.dateFrom, dateTo: self.dateTo)
//        try await fetchTimeEntries()
    }
    
    func setDateTo(date: Date) async throws {
        self.dateTo = date
//        self.client = RedmineHTTPClient(dateFrom: self.dateFrom, dateTo: self.dateTo)
//        try await fetchTimeEntries()
    }
}
