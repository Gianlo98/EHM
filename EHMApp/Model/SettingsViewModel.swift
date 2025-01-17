//
//  SettingsViewModel.swift
//  EHM
//
//  Created by Gianlo Personal on 17.01.2025.
//

import Foundation
import SwiftUI
import KeychainSwift


class SettingsViewModel: ObservableObject {
    @Published var redmineApiUrl: String = ""
    @Published var redmineApiKey: String = ""
    @Published var fixedCostTreshold: Double = 2000
    @Published var hourlyIncome: Double = 50
    @Published var monthlyHourTreshold: Double = 165
    @Published var userFetchMessage: String = ""
    @Published var userFetchMessageColor: Color = .red

    func loadSettings() {
        let keychain = KeychainSwift()
        self.redmineApiKey = keychain.get("redmineApiKey") ?? ""
        self.redmineApiUrl = UserDefaults.standard.string(forKey: "redmineApiUrl") ?? ""
        self.fixedCostTreshold = UserDefaults.standard.double(forKey: "fixedCostTreshold")
        self.hourlyIncome = UserDefaults.standard.double(forKey: "hourlyIncome")
        self.monthlyHourTreshold = UserDefaults.standard.double(forKey: "monthlyHourTreshold")
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
