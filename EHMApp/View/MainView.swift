//
//  ContentView.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import SwiftUI

struct MainView: View {
    @AppStorage("isConfigured") private var isConfigured: Bool = false
    
    var body: some View {
        if isConfigured {
            TabView {
                TimeEntriesView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Time entries")
                    }
                ChartView(viewModel: ChartViewModel(service: TimeEntriesService(provider: RedmineTimeEntriesProvider(client: RedmineHTTPClient()))))
                    .tabItem {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("Trend")
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
            }
        } else {
            SettingsView()
        }
    }
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        let fakeDownloader = FakeRedmineDownloader()
        let client = RedmineHTTPClient(downloader: fakeDownloader)
        let provider = RedmineTimeEntriesProvider(client: client)
        let service = TimeEntriesService(provider: provider)
        let chartViewModel = ChartViewModel(service: service)
        
        MainView()
            .environmentObject(provider)
            .environmentObject(chartViewModel)
    }
}
