//
//  ContentView.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            TimeEntriesView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Time entries")
                }
            ChartView()
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
    }
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        let fakeDownloader = FakeRedmineDownloader()
        let client = RedmineHTTPClient(downloader: fakeDownloader)
        
        MainView()
            .environmentObject(RedmineTimeEntriesProvider(client: client))
        
    }
}
