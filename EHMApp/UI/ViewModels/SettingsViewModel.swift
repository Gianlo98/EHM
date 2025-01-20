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
    private var dataManager: DataManager = DataManager.shared
    
    @Published var redmineApiUrl: String = ""
    @Published var redmineApiKey: String = ""
    @Published var fixedCostTreshold: Double = 2000
    @Published var hourlyIncome: Double = 50
    @Published var monthlyHourTreshold: Double = 165
    @Published var userFetchMessage: String? = nil
    @Published var userFetchMessageColor: Color = .primary
    @Published var dateFrom: Date = DataManager.shared.dateFrom
    @Published var dateTo: Date = DataManager.shared.dateTo
    @AppStorage(StorageKey<Bool>.isConfigured.name) var isConfigured: Bool = false


    init() {
        loadSettings()
    }
    
    func loadSettings() {
        self.redmineApiKey = DataStorage.shared.loadKey(key: .redmineApiKey)
        self.redmineApiUrl = DataStorage.shared.loadKey(key: .redmineApiUrl)
        self.fixedCostTreshold = DataStorage.shared.loadKey(key: .fixedCostThreshold)
        self.hourlyIncome = DataStorage.shared.loadKey(key: .hourlyIncome)
        self.monthlyHourTreshold = DataStorage.shared.loadKey(key: .monthlyHourThreshold)
        self.isConfigured = DataStorage.shared.loadKey(key: .isConfigured)
    }
    
    func updateSettings<T>(value: T, key: StorageKey<T>) {
        DataStorage.shared.updateKey(value: value, key: key)
    }
    
    func attemptFetchCurrentUser(completion: @escaping (Bool) -> Void) {
            guard !redmineApiKey.isEmpty, !redmineApiUrl.isEmpty else {
                userFetchMessage = "Invalid Redmine credentials"
                userFetchMessageColor = .red
                completion(false)
                return
            }
            Task {
                do {
                    try await dataManager.fetchData()
                    let user = dataManager.currentUser!
                    userFetchMessage = "User found: \(user.firstname) \(user.lastname)"
                    userFetchMessageColor = .primary
                    completion(true) // Indicate success
                } catch {
                    userFetchMessage = "Failed to fetch user."
                    userFetchMessageColor = .red
                    completion(false) // Indicate failure
                }
            }
        }
    
    func setDateFrom(date: Date) {
        DataManager.shared.dateFrom = date
    }
    
    func setDateTo(date: Date) {
        DataManager.shared.dateFrom = date
    }
}
