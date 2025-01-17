//
//  SettingsView_macOS.swift
//  EHM
//
//  Created by Gianlo Personal on 17.01.2025.
//

import SwiftUI
import KeychainSwift

struct SettingsView_macOS: View {
    @EnvironmentObject var timeEntriesProvider: RedmineTimeEntriesProvider
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Settings").font(.largeTitle).padding(.bottom, 20)

            Group {
                HStack {
                    Text("Date From:")
                    DatePicker("", selection: $timeEntriesProvider.dateFrom, in: ...Date.now, displayedComponents: .date)
                        .labelsHidden()
                        .onChange(of: timeEntriesProvider.dateFrom, initial: false) { _, newValue in
                            Task {
                                try await timeEntriesProvider.setDateFrom(date: newValue)
                            }
                        }
                }
                
                HStack {
                    Text("Date To:")
                    DatePicker("", selection: $timeEntriesProvider.dateTo, in: ...Date.now.endOfMonth(), displayedComponents: .date)
                        .labelsHidden()
                        .onChange(of: timeEntriesProvider.dateTo, initial: false) { _, newValue in
                            Task {
                                try await timeEntriesProvider.setDateTo(date: newValue)
                            }
                        }
                }
            }

            Group {
                HStack {
                    Text("Redmine API URL:")
                    TextField("Enter URL", text: $viewModel.redmineApiUrl)
                        .onChange(of: viewModel.redmineApiUrl, initial: false) { _, newValue in
                            viewModel.updateSettings(value: newValue, key: .redmineApiUrl)
                            viewModel.attemptFetchCurrentUser(timeEntriesProvider: timeEntriesProvider)
                        }
                }
                
                HStack {
                    Text("Redmine API Key:")
                    SecureField("Enter API Key", text: $viewModel.redmineApiKey)
                        .onChange(of: viewModel.redmineApiKey, initial: false) { _, newValue in
                            viewModel.updateSettings(value: newValue, key: .redmineApiKey)
                            viewModel.attemptFetchCurrentUser(timeEntriesProvider: timeEntriesProvider)
                        }
                }
            }

            Group {
                HStack {
                    Text("Fixed Cost Threshold:")
                    TextField("", value: $viewModel.fixedCostTreshold, format: .currency(code: "CHF"))
                        .onChange(of: viewModel.fixedCostTreshold, initial: false) { _, newValue in
                            viewModel.updateSettings(value: newValue, key: .fixedCostThreshold)
                        }
                }
                
                HStack {
                    Text("Hourly Income:")
                    TextField("", value: $viewModel.hourlyIncome, format: .currency(code: "CHF"))
                        .onChange(of: viewModel.hourlyIncome, initial: false) { _, newValue in
                            viewModel.updateSettings(value: newValue, key: .hourlyIncome)
                        }
                }
                
                HStack {
                    Text("Monthly Hours Threshold:")
                    TextField("", value: $viewModel.monthlyHourTreshold, format: .number)
                        .onChange(of: viewModel.monthlyHourTreshold, initial: false) { _, newValue in
                            viewModel.updateSettings(value: newValue, key: .monthlyHourThreshold)
                        }
                }
            }
            
            Spacer()
        }
        .padding()
        .frame(minWidth: 600, minHeight: 400)
        .onAppear {
            viewModel.loadSettings()
        }
    }
}
