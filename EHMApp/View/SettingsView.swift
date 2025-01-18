import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var timeEntriesProvider: RedmineTimeEntriesProvider
    @StateObject private var viewModel = SettingsViewModel()
    @AppStorage("isConfigured") private var isConfigured: Bool = false // AppStorage to track app configuration state
    
    var body: some View {
        NavigationView {
            VStack {
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
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .onChange(of: viewModel.redmineApiUrl, initial: false) { _, newValue in
                                viewModel.updateSettings(value: newValue, key: .redmineApiUrl)
                            }
                        
                        SecureField("Redmine API Key", text: $viewModel.redmineApiKey)
                            .onChange(of: viewModel.redmineApiKey, initial: false) { _, newValue in
                                viewModel.updateSettings(value: newValue, key: .redmineApiKey)
                            }
                        
                        if let message = viewModel.userFetchMessage {
                            Text(message)
                                .foregroundColor(viewModel.userFetchMessageColor)
                                .font(.footnote)
                        }
                    }
                    
                    Section("Fixed Cost Threshold") {
                        DecimalTextField(value: $viewModel.fixedCostTreshold, placeholder: "Fixed Cost Threshold")
                            .onChange(of: viewModel.fixedCostTreshold, initial: false) { _, newValue in
                                viewModel.updateSettings(value: newValue, key: .fixedCostThreshold)
                            }
                    }
                    
                    Section("Hourly Income") {
                        DecimalTextField(value: $viewModel.hourlyIncome, placeholder: "Hourly Income")
                            .onChange(of: viewModel.hourlyIncome, initial: false) { _, newValue in
                                viewModel.updateSettings(value: newValue, key: .hourlyIncome)
                            }
                    }
                    
                    Section("Monthly Hours Threshold") {
                        DecimalTextField(value: $viewModel.monthlyHourTreshold, placeholder: "Monthly Hours Threshold")
                            .onChange(of: viewModel.monthlyHourTreshold, initial: false) { _, newValue in
                                viewModel.updateSettings(value: newValue, key: .monthlyHourThreshold)
                            }
                    }
                }
                
                if !isConfigured {
                    VStack {
                        Button(action: {
                            viewModel.attemptFetchCurrentUser(timeEntriesProvider: timeEntriesProvider) { success in
                                if success {
                                    isConfigured = true
                                }
                            }
                        }) {
                            Text("Start using EHM")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding([.leading, .trailing])
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                viewModel.loadSettings()
            }
        }
    }
}

struct SettingsView_Preview: PreviewProvider {
    static var previews: some View {
        // Mock Data for Preview
        let mockProvider = RedmineTimeEntriesProvider()
        mockProvider.dateFrom = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
        mockProvider.dateTo = Date()
        
        let mockViewModel = SettingsViewModel()
        mockViewModel.redmineApiUrl = "https://redmine.example.com"
        mockViewModel.redmineApiKey = "sample_api_key"
        mockViewModel.fixedCostTreshold = 2000.0
        mockViewModel.hourlyIncome = 35.0
        mockViewModel.monthlyHourTreshold = 165.0
        
        return SettingsView()
            .environmentObject(mockProvider)
            .previewDisplayName("Settings View Preview")
    }
}
