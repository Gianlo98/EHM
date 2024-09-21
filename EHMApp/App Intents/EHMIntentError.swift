//
//  TrailIntentError.swift
//  EHM
//
//  Created by Gianlo Personal on 21.09.2024.
//
import Foundation

enum EHMIntentError: Error, CustomLocalizedStringResourceConvertible {
    case redmineFetchError
    case invalidDateError
    
    var localizedStringResource: LocalizedStringResource {
        switch self {
        case .redmineFetchError:
            return "Unable to fetch time entries from redmine."
        case .invalidDateError:
            return "Invalid date range"
        }
    }
}
