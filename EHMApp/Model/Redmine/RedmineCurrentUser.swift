//
//  CurrentUser.swift
//  ehm
//
//  Created by Gianlo Personal on 10.02.2024.
//

import Foundation

struct RedmineCurrentUser: Identifiable {
    let id: Int
    let login: String
    let firstname: String
    let lastname: String
    let avatarUrl: String
}


extension RedmineCurrentUser: Decodable {
    private enum CodingKeys: String, CodingKey {
        case user
    }
    
    private enum UserKeys: String, CodingKey {
        case id
        case login
        case firstname
        case lastname
        case avatarUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let user = try values.nestedContainer(keyedBy: UserKeys.self, forKey: .user)
        
        id = try user.decode(Int.self, forKey: .id)
        login = try user.decode(String.self, forKey: .login)
        firstname = try user.decode(String.self, forKey: .firstname)
        lastname = try user.decode(String.self, forKey: .lastname)
        avatarUrl = try user.decode(String.self, forKey: .avatarUrl)
    }
}
