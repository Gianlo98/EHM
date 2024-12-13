//
//  EMHShortcusts.swift
//  EHM
//
//  Created by Gianlo Personal on 26.09.2024.
//
// Abstract:
// An array of intents that the app makes available as App Shortcuts.
//

import Foundation
import AppIntents

class EHMShortcuts: AppShortcutsProvider {
    
    static var shortcutTileColor = ShortcutTileColor.navy
    
    static var appShortcuts: [AppShortcut] {

        AppShortcut(intent: MonthlyTimeEntries(), phrases: [
            "Show monthly time entries in \(.applicationName)",
            "Monthly redmine entries",
            "Time booked this month"
        ],
        shortTitle: "Month time entries",
        systemImageName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
        
        AppShortcut(intent: MonthlyTimeEntriesWithAverage(), phrases: [
            "Show monthly time entries with statistics in \(.applicationName)",
            "Monthly redmine entries with statistics",
            "Time booked this month with statistics",
            "Work statistics this month"
        ],
        shortTitle: "Month time entries with statistics",
        systemImageName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
        
        AppShortcut(intent: WeeklyTimeEntries(), phrases: [
            "Show weekly time entries in \(.applicationName)",
            "Weekly redmine entries",
            "Time booked this week"
        ],
        shortTitle: "Week time entries",
        systemImageName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
        
        AppShortcut(intent: WeeklyTimeEntriesWithAverage(), phrases: [
            "Show weekly time entries with statistics in \(.applicationName)",
            "Monthly weekly entries with statistics",
            "Time booked this week with statistics",
            "Work statistics this week"
        ],
        shortTitle: "Week time entries with statistics",
        systemImageName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
    }
}
