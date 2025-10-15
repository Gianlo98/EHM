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

final class EHMShortcuts: AppShortcutsProvider {
    
    static let shortcutTileColor = ShortcutTileColor.navy
    
    static var appShortcuts: [AppShortcut] {
        return [
            AppShortcut(
                intent: MonthlyTimeEntries(),
                phrases: [
                    "Show monthly time entries in ${applicationName}",
                    "Monthly redmine entries in ${applicationName}",
                    "Time booked this month in ${applicationName}"
                ],
                shortTitle: "Month time entries",
                systemImageName: "clock.arrow.trianglehead.counterclockwise.rotate.90"
            ),
            AppShortcut(
                intent: MonthlyTimeEntriesWithAverage(),
                phrases: [
                    "Show monthly time entries with statistics in ${applicationName}",
                    "Monthly redmine entries with statistics in ${applicationName}",
                    "Time booked this month with statistics in ${applicationName}",
                    "Work statistics this month in ${applicationName}"
                ],
                shortTitle: "Month time entries with statistics",
                systemImageName: "clock.arrow.trianglehead.counterclockwise.rotate.90"
            ),
            AppShortcut(
                intent: WeeklyTimeEntries(),
                phrases: [
                    "Show weekly time entries in ${applicationName}",
                    "Weekly redmine entries in ${applicationName}",
                    "Time booked this week in ${applicationName}"
                ],
                shortTitle: "Week time entries",
                systemImageName: "clock.arrow.trianglehead.counterclockwise.rotate.90"
            ),
            AppShortcut(
                intent: WeeklyTimeEntriesWithAverage(),
                phrases: [
                    "Show weekly time entries with statistics in ${applicationName}",
                    "Weekly entries with statistics in ${applicationName}",
                    "Time booked this week with statistics in ${applicationName}",
                    "Work statistics this week in ${applicationName}"
                ],
                shortTitle: "Week time entries with statistics",
                systemImageName: "clock.arrow.trianglehead.counterclockwise.rotate.90"
            )
        ]
    }
}
