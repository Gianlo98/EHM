//
//  ContentView.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import SwiftUI

struct MainView: View {
    @AppStorage(StorageKey<Bool>.isConfigured.name) private var isConfigured: Bool = false
    
    var body: some View {
        if isConfigured {
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
        } else {
            SettingsView()
        }
    }
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        let fakeDownloader = FakeRedmineDownloader(feature: testFeature_te04)
        let fakeClient = RedmineHTTPClient(downloader: fakeDownloader)
        let fakeProvider = RedmineTimeEntriesProvider(client: fakeClient)
        let _ = DataManager.initialize(provider: fakeProvider)
        
        let previewUserDefaults: UserDefaults = {
            let d = UserDefaults(suiteName: "preview_user_defaults")!
            d.set(false, forKey: StorageKey<Bool>.isConfigured.name)
            return d
        }()
        
        Group {
            MainView()
                .previewDisplayName("Configured")
            
            MainView()
                .previewDisplayName("Not Configured")
                .defaultAppStorage(previewUserDefaults)
        }
    }
}
