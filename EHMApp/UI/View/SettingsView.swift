import SwiftUI

struct SettingsView: View {

    @StateObject private var viewModel = SettingsViewModel()
    @AppStorage(StorageKey<Bool>.isConfigured.name) private var isConfigured: Bool = false

    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("Date Range") {
                        DatePicker("Date From", selection: $viewModel.dateFrom, in: ...Date.now, displayedComponents: .date)
                            .onChange(of: viewModel.dateFrom, initial: false) { _, newValue in
                                viewModel.setDateFrom(date: newValue)
                            }
                        
                        DatePicker("Date To", selection: $viewModel.dateTo, in: ...Date.now.endOfMonth(), displayedComponents: .date)
                            .onChange(of: viewModel.dateTo, initial: false) { _, newValue in
                                viewModel.setDateTo(date: newValue)
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
                            viewModel.attemptFetchCurrentUser() { success in
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
        let fakeDownloader = FakeRedmineDownloader(feature: testFeature_te04)
        let fakeClient = RedmineHTTPClient(downloader: fakeDownloader)
        let mockProvider = RedmineTimeEntriesProvider(client: fakeClient)
        let _ = DataManager.initialize(provider: mockProvider)
        
        let previewUserDefaults: UserDefaults = {
            let d = UserDefaults(suiteName: "preview_user_defaults")!
            d.set(false, forKey: StorageKey<Bool>.isConfigured.name)
            return d
        }()
        
        Group {
            SettingsView()
                .previewDisplayName("Configured")
            
            SettingsView()
                .previewDisplayName("Not Configured")
                .defaultAppStorage(previewUserDefaults)
        }
        
    }
}
