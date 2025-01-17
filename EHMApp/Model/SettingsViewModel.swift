//
//  SettingsViewModel.swift
//  EHM
//
//  Created by Gianlo Personal on 17.01.2025.
//

import Foundation
import SwiftUI
import KeychainSwift

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var redmineApiUrl: String = ""
    @Published var redmineApiKey: String = ""
    @Published var fixedCostTreshold: Double = 2000
    @Published var hourlyIncome: Double = 50
    @Published var monthlyHourTreshold: Double = 165
    @Published var userFetchMessage: String = ""
    @Published var userFetchMessageColor: Color = .red

    func loadSettings() {
        self.redmineApiKey = DataStorage.shared.loadKey(key: .redmineApiKey)
        self.redmineApiUrl = DataStorage.shared.loadKey(key: .redmineApiUrl)
        self.fixedCostTreshold = DataStorage.shared.loadKey(key: .fixedCostThreshold)
        self.hourlyIncome = DataStorage.shared.loadKey(key: .hourlyIncome)
        self.monthlyHourTreshold = DataStorage.shared.loadKey(key: .monthlyHourThreshold)
    }
    
    func updateSettings<T>(value: T, key: StorageKey<T>) {
        DataStorage.shared.updateKey(value: value, key: key)
    }

    func attemptFetchCurrentUser(timeEntriesProvider: RedmineTimeEntriesProvider) {
        guard !redmineApiKey.isEmpty, !redmineApiUrl.isEmpty else {
            userFetchMessage = "Invalid redmine credentials"
            userFetchMessageColor = .red
            return
        }
        Task {
            do {
                let user = try await timeEntriesProvider.fetchCurrentUser()
                userFetchMessage = "User found: \(user.firstname) \(user.lastname)"
                userFetchMessageColor = .primary
            } catch {
                userFetchMessage = "Failed to fetch user."
                userFetchMessageColor = .red
            }
        }
    }
}
