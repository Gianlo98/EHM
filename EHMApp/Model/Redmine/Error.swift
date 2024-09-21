//
//  Error.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import Foundation

enum RedmineError: Error {
    case missingData
    case networkError(comment: String)
    case keychainError
    case missingCredentials
    case unexpectedError(error: Error)
}

extension RedmineError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("Data error", comment: "")
        case .networkError(let comment):
            return NSLocalizedString("Network error", comment: comment)
        case .keychainError:
            return NSLocalizedString("Keychain error", comment: "")
        case .missingCredentials:
            return NSLocalizedString("Missing credentials", comment: "")
        case .unexpectedError(let error):
            return NSLocalizedString("Received unexpected error. \(error.localizedDescription)", comment: "")
        }
    }
}
