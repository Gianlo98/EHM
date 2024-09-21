//
//  HTTPClient.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import Foundation

class RedmineHTTPClient {
    private let downloader: any RedmineDownloader
    private let dateFrom: Date
    private let dateTo: Date
    private var redmineUrl: String {
        return UserDefaults.standard.string(forKey: "redmineApiUrl") ?? ""
    }
    
    private lazy var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        aDecoder.dateDecodingStrategy = .millisecondsSince1970
        return aDecoder
    }()
    
    var timeEntries: [RedmineTimeEntry] {
        get async throws {
            guard redmineUrl != "" else {
                throw RedmineError.missingCredentials
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let fromStr: String = dateFormatter.string(from: dateFrom)
            let toStr: String = dateFormatter.string(from: dateTo)
            
            var entries: [RedmineTimeEntry] = []
            var fetchedEntries = 0
            var currentOffset = 0
            let limit = 100
            let userId = try await self.currentUser.id
            
            var timeEntryResult = RedmineTimeEntriesResult.EMPTY
            
            repeat {
                let urlString = "\(redmineUrl)/time_entries.json?user_id=\(userId)&limit=\(limit)&offset=\(currentOffset)&from=\(fromStr)&to=\(toStr)"
                guard let url = URL(string: urlString) else {
                    throw RedmineError.networkError(comment: "Invalid URL \(urlString)")
                }
                
                let data = try await downloader.fetch(from: url)
                timeEntryResult = try decoder.decode(RedmineTimeEntriesResult.self, from: data)
                
                entries.append(contentsOf: timeEntryResult.entries)
                fetchedEntries += timeEntryResult.entries.count
                currentOffset += limit
            } while fetchedEntries < timeEntryResult.totalCount
            
            return entries
        }
    }
    
    var currentUser: RedmineCurrentUser {
        get async throws {
            guard redmineUrl != "" else {
                throw RedmineError.missingCredentials
            }
            
            let url = URL(string: "\(redmineUrl)/users/current.json")!
            let data = try await downloader.fetch(from: url)
            let currentUserResult = try decoder.decode(RedmineCurrentUser.self, from: data)
            return currentUserResult
        }
    }
    
    convenience init (downloader: any RedmineDownloader = URLSession.shared) {
        self.init(downloader: downloader, dateFrom: Date.now.startOfMonth(), dateTo: Date.now.endOfMonth())
    }
    
    init(downloader: any RedmineDownloader = URLSession.shared, dateFrom: Date, dateTo: Date) {
        self.downloader = downloader
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }
}


extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}
