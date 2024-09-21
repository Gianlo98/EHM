//
//  SettingsView.swift
//  ehm
//
//  Created by Gianlo Personal on 01.02.23.
//

import Foundation
import SwiftUI
import KeychainSwift

struct SettingsView: View {
    @EnvironmentObject var timeEntriesProvider: RedmineTimeEntriesProvider
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    @State private var dateFrom = Date.now
    @State private var dateTo = Date.now
    @State private var redmineApiKey: String = ""
    @State private var redmineApiUrl: String = ""
    @State private var userFetchMessage: String = ""
    @State private var userFetchMessageColor: Color = .red
    @State private var fixedCostTreshold: Double = 2000
    @State private var hourlyIncome: Double = 50
    @State private var monthlyHourTreshold: Double = 165
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    
                    Section("Date range") {
                        DatePicker(selection: $timeEntriesProvider.dateFrom, in: ...Date.now, displayedComponents: .date) {
                            Text("Date From")
                        }.onChange(of: timeEntriesProvider.dateFrom) {
                            Task {
                                try await timeEntriesProvider.setDateFrom(date: timeEntriesProvider.dateFrom)
                            }
                        }
                        
                        DatePicker(selection: $timeEntriesProvider.dateTo, in: ...Date.now.endOfMonth(), displayedComponents: .date) {
                            Text("Date to")
                        }.onChange(of: timeEntriesProvider.dateTo) {
                            Task {
                                try await timeEntriesProvider.setDateTo(date: timeEntriesProvider.dateTo)
                            }
                        }
                    }
                    
                    Section {
                        TextField("URL", text: $redmineApiUrl)
                            .autocapitalization(.none)
                            .onChange(of: redmineApiUrl) {
                                UserDefaults.standard.set(redmineApiUrl, forKey: "redmineApiUrl")
                                attemptFetchCurrentUser()
                            }
                        
                        SecureField(
                            "API Key",
                            text: $redmineApiKey
                            
                        ).textContentType(.password)
                            .disableAutocorrection(true)
                            .onChange(of: redmineApiKey) {
                                saveApiKey(redmineApiKey)
                                attemptFetchCurrentUser()
                            }
                        
                    } header: {
                        Text("Redmine settings")
                    } footer: {
                        Text(userFetchMessage)
                            .foregroundColor(userFetchMessageColor)
                    }
                    
                    Section("Fixed cost treshold") {
                        TextField("Fixed cost treshold", value: $fixedCostTreshold, format: .currency(code: "CHF"))
                            .keyboardType(.decimalPad)
                            .onChange(of: fixedCostTreshold) {
                                UserDefaults.standard.set(fixedCostTreshold, forKey: "fixedCostTreshold")
                            }
                    }
                    Section("Hourly Income") {
                        TextField("Hourly Income", value: $hourlyIncome, format: .currency(code: "CHF"))
                            .keyboardType(.decimalPad)
                            .onChange(of: hourlyIncome) {
                                UserDefaults.standard.set(hourlyIncome, forKey: "hourlyIncome")
                            }
                    }
                    
                    Section("Monthly hours treshold") {
                        TextField("Hourly Income", value: $monthlyHourTreshold, format: .number)
                            .keyboardType(.decimalPad)
                            .onChange(of: monthlyHourTreshold) {
                                UserDefaults.standard.set(monthlyHourTreshold, forKey: "monthlyHourTreshold")
                            }
                    }
                    
                }.listStyle(.insetGrouped)
            }
            .navigationTitle("Settings").navigationBarTitleDisplayMode(.inline)
        }.onAppear {
            loadSettings()
        }
    }
    
    private func saveApiKey(_ key: String) {
        let keychain = KeychainSwift()
        keychain.set(key, forKey: "redmineApiKey")
    }
    
    private func loadSettings() {
        let keychain = KeychainSwift()
        self.redmineApiKey = keychain.get("redmineApiKey") ?? ""
        self.redmineApiUrl = UserDefaults.standard.string(forKey: "redmineApiUrl") ?? ""
        self.fixedCostTreshold = UserDefaults.standard.double(forKey: "fixedCostTreshold")
        self.hourlyIncome = UserDefaults.standard.double(forKey: "hourlyIncome")
        
    }
    
    func attemptFetchCurrentUser() {
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


struct SettingsViewProvider: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(RedmineTimeEntriesProvider())
        
    }
}
