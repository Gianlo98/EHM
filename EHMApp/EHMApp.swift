//
//  ehmApp.swift
//  ehm
//  Earning and Hobby Management
//  Created by Gianlo Personal on 29.01.23.
//

import SwiftUI
import BackgroundTasks

@main
struct ehmApp: App {
    
    @Environment(\.scenePhase) private var phase
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }.onChange(of: phase) {
            if phase == .background {
                scheduleAppRefresh()
            }
        } .backgroundTask(.appRefresh("com.occhipinti.ehm.RedmineFetcher.refresh")) {
            try? await DataManager.shared.fetchData()
            await scheduleAppRefresh()
        }
    }

    private func scheduleAppRefresh() {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .weekday], from: now)

        // Check if today is a working day (Monday to Friday)
        let isWorkingDay = (components.weekday ?? 0) >= 2 && (components.weekday ?? 0) <= 6

        // Check if the current time is between 8 AM and 8 PM
        let isWithinWorkingHours = (components.hour ?? 0) >= 8 && (components.hour ?? 0) < 20

        guard isWorkingDay, isWithinWorkingHours else {
            print("Not scheduling: Outside working hours or non-working day")
            return
        }

        // Schedule the next refresh at the next 30-minute slot
        let nextScheduleDate: Date
        if let currentMinute = components.minute {
            let minutesToNextSlot = 30 - (currentMinute % 30)
            nextScheduleDate = calendar.date(byAdding: .minute, value: minutesToNextSlot, to: now) ?? now
        } else {
            print("Failed to calculate next schedule time")
            return
        }

        let request = BGAppRefreshTaskRequest(identifier: "com.occhipinti.ehm.RedmineFetcher.refresh")
        request.earliestBeginDate = nextScheduleDate

        do {
            try BGTaskScheduler.shared.submit(request)
            print("Scheduled app refresh for \(nextScheduleDate)")
        } catch {
            print("Failed to schedule app refresh: \(error)")
        }
    }
     
}
