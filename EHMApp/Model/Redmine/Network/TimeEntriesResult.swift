//
//  TimeEntriesJSON.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import Foundation

struct RedmineTimeEntriesResult: Decodable {
    private(set) var entries: [RedmineTimeEntry] = []
    var limit: Int = 0
    var totalCount: Int = 0
    var offset: Int = 0
    
    
    private enum CodingKeys: String, CodingKey {
        case entries = "time_entries"
        case totalCount = "total_count"
        case offset
        case limit
    }
    
    static let EMPTY = RedmineTimeEntriesResult(entries: [], limit: 0, totalCount: 0, offset: 0)
    
    
    init(entries: [RedmineTimeEntry], limit: Int, totalCount: Int, offset: Int) {
        self.entries = entries
        self.limit = limit
        self.totalCount = totalCount
        self.offset = offset
    }
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        var entriesContainer = try rootContainer.nestedUnkeyedContainer(forKey: .entries)
        while !entriesContainer.isAtEnd {
            if let timeEntry = try? entriesContainer.decode(RedmineTimeEntry.self) {
                entries.append(timeEntry)
            }
        }
        
        if let rawLimit = try? rootContainer.decode(Int.self, forKey: .limit),
           let rawCount = try? rootContainer.decode(Int.self, forKey: .totalCount),
           let rawOffset = try? rootContainer.decode(Int.self, forKey: .offset) {
            
            self.limit = rawLimit
            self.totalCount = rawCount
            self.offset = rawOffset
            
        } else {
            throw RedmineError.missingData
        }
    }
}
