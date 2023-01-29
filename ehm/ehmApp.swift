//
//  ehmApp.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import SwiftUI

@main
struct ehmApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
