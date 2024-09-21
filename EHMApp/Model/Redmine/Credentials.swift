//
//  Credentials.swift
//  ehm
//
//  Created by Gianlo Personal on 02.02.23.
//

import Foundation

//struct Credentials {
//    var key: String
//}
//
//enum KeychainError: Error {
//    case noKey
//    case unexpectedPasswordData
//    case unhandledError(status: OSStatus)
//}
//
//public static getCredentials() -> Credentials throws {
//    let addquery: [String: Any] = [kSecClass as String: kSecClassKey,
//                                   kSecAttrApplicationTag as String: "renuo_redmine",
//                                   kSecValueRef as String: "keyyyy"]
//    
//    let status = SecItemCopyMatching(addquery as CFDictionary, nil)
//    guard status == errSecSuccess else { throw  KeychainError.unexpectedPasswordData  }
//}
