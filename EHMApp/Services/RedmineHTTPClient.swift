//
//  HTTPClient.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import Foundation
import OSLog

class RedmineHTTPClient {
    private let downloader: any RedmineDownloader
    private let dateFrom: Date
    private let dateTo: Date
    private var redmineUrl: String {
        return DataStorage.shared.loadKey(key: .redmineApiUrl)
    }
    
    private lazy var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        aDecoder.dateDecodingStrategy = .millisecondsSince1970
        return aDecoder
    }()
    
    convenience init (downloader: any RedmineDownloader = URLSession.shared) {
        self.init(downloader: downloader, dateFrom: Date.now.startOfMonth(), dateTo: Date.now.endOfMonth())
    }
    
    init(downloader: any RedmineDownloader = URLSession.shared as any RedmineDownloader, dateFrom: Date, dateTo: Date) {
        self.downloader = downloader
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }
    
    
    var timeEntries: [RedmineTimeEntry] {
        get async throws {
            guard redmineUrl != "" else {
                throw RedmineError.missingCredentials
            }
            
            Logger.providerLogger.debug("[RedmineHTTPClient] Fetching from redmine url \(self.redmineUrl, privacy: .private)")
            
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
            // Check if the Redmine URL is empty
            guard !redmineUrl.isEmpty else {
                throw RedmineError.missingCredentials
            }
            
            Logger.providerLogger.debug("[RedmineHTTPClient] Fetching current user from \(self.redmineUrl)")
            // Safely unwrap the URL
            guard let url = URL(string: "\(redmineUrl)/users/current.json") else {
                throw RedmineError.invalidUrl
            }
            
            // Attempt to fetch data from the URL
            let data = try await downloader.fetch(from: url)
            
            // Decode the data into a RedmineCurrentUser object
            let currentUserResult = try decoder.decode(RedmineCurrentUser.self, from: data)
            
            return currentUserResult
        }
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
