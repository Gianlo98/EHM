//
//  Project.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import Foundation

struct RedmineProject: Identifiable {
    let id: Int
    let name: String
}

extension RedmineProject: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawId = try? values.decode(Int.self, forKey: .id)
        let rawName = try? values.decode(String.self, forKey: .name)
        
        guard let id = rawId,
              let name = rawName
        else {
            throw RedmineError.missingData
        }
        
        self.id = id
        self.name = name
    }
}
