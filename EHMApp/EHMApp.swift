//
//  ehmApp.swift
//  ehm
//  Earning and Hobby Management
//  Created by Gianlo Personal on 29.01.23.
//

import SwiftUI

@main
struct ehmApp: App {
    @StateObject var timeEntryProvider = RedmineTimeEntriesProvider()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(timeEntryProvider)
        }
    }
}
