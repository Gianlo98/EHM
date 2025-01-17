import SwiftUI
import KeychainSwift

struct SettingsView_iOS: View {
    @EnvironmentObject var timeEntriesProvider: RedmineTimeEntriesProvider
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section("Date Range") {
                    DatePicker("Date From", selection: $timeEntriesProvider.dateFrom, in: ...Date.now, displayedComponents: .date)
                        .onChange(of: timeEntriesProvider.dateFrom, initial: false) { _, newValue in
                            Task {
                                try await timeEntriesProvider.setDateFrom(date: newValue)
                            }
                        }
                    
                    DatePicker("Date To", selection: $timeEntriesProvider.dateTo, in: ...Date.now.endOfMonth(), displayedComponents: .date)
                        .onChange(of: timeEntriesProvider.dateTo, initial: false) { _, newValue in
                            Task {
                                try await timeEntriesProvider.setDateTo(date: newValue)
                            }
                        }
                }
                
                Section("Redmine Settings") {
                    TextField("Redmine API URL", text: $viewModel.redmineApiUrl)
#if os(iOS)
                        .autocapitalization(.none)
#endif
                        .disableAutocorrection(true)
                        .onChange(of: viewModel.redmineApiUrl, initial: false) { _, newValue in
                            UserDefaults.standard.set(newValue, forKey: "redmineApiUrl")
                            viewModel.attemptFetchCurrentUser(timeEntriesProvider: timeEntriesProvider)
                        }
                    
                    SecureField("Redmine API Key", text: $viewModel.redmineApiKey)
                        .onChange(of: viewModel.redmineApiKey, initial: false) { _, newValue in
                            let keychain = KeychainSwift()
                            keychain.set(newValue, forKey: "redmineApiKey")
                            viewModel.attemptFetchCurrentUser(timeEntriesProvider: timeEntriesProvider)
                        }
                }
                
                Section("Fixed Cost Threshold") {
                    DecimalTextField(value: $viewModel.fixedCostTreshold, placeholder: "Fixed Cost Threshold")
                        .onChange(of: viewModel.fixedCostTreshold, initial: false) { _, newValue in
                            UserDefaults.standard.set(newValue, forKey: "fixedCostTreshold")
                        }
                }
                
                Section("Hourly Income") {
                    DecimalTextField(value: $viewModel.hourlyIncome, placeholder: "Hourly Income")
                        .onChange(of: viewModel.hourlyIncome, initial: false) { _, newValue in
                            UserDefaults.standard.set(newValue, forKey: "hourlyIncome")
                        }
                }
                
                Section("Monthly Hours Threshold") {
                    DecimalTextField(value: $viewModel.monthlyHourTreshold, placeholder: "Monthly Hours Threshold")
                        .onChange(of: viewModel.monthlyHourTreshold, initial: false) { _, newValue in
                            UserDefaults.standard.set(newValue, forKey: "monthlyHourTreshold")
                        }
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                viewModel.loadSettings()
            }
        }
    }
}
