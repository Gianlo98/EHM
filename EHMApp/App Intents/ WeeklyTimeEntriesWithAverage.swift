import AppIntents
import Foundation
import OSLog

struct  WeeklyTimeEntriesWithAverage: AppIntent {
    
    static var title: LocalizedStringResource = "Get how many hours did I work this week and the average hours per day left this month."
    static var description = IntentDescription("Returns the number of hours of work this week and calculates average hours per remaining day to meet the monthly threshold.")
    static var openAppWhenRun: Bool = false

    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog & ReturnsValue<Double> {
        Logger.intentLogging.debug("[WeeklyTimeEntries] Performing intent")
        let timeEntriesProvider = RedmineTimeEntriesProvider()
        
        // Fetch the time entries from Redmine
        do {
            try await timeEntriesProvider.fetchTimeEntries()
        } catch {
            Logger.intentLogging.debug("[WeeklyTimeEntries] Unable to fetch Redmine entries.")
            throw EHMIntentError.redmineFetchError
        }
        
        // Get time entries for the current week using the utility method
        let timeEntriesThisWeek = TimeEntryUtils.timeEntriesForCurrentWeek(timeEntriesProvider.timeEntries)
        
        // Calculate total hours worked this week
        let totalHoursThisWeek = timeEntriesThisWeek.reduce(0) { total, entry in
            total + entry.hours
        }
        
        // Fetch the monthly threshold from UserDefaults (default to 160 hours if not set)
        let monthlyThreshold: Double = DataStorage.shared.loadKey(key: .monthlyHourThreshold)
        
        // Calculate the total hours worked for the month so far
        let workedMonthHours = timeEntriesProvider.summedTimeEntries.last?.value ?? 0.0
        
        // Calculate the average hours per day needed to meet the monthly threshold
        let (_, avgHoursPerDay) = TimeEntryUtils.getAverageHoursPerDayToReachMonthlyThreshold(monthlyThreshold: monthlyThreshold, monthHours: workedMonthHours)

        // Format the hours for display
        let formattedHours = TimeEntryUtils.formatHours(totalHoursThisWeek)
        let formattedAvgHoursPerDay = TimeEntryUtils.formatHours(avgHoursPerDay)
        let formattedMonthlyThreshold = TimeEntryUtils.formatHours(monthlyThreshold)
        
        // Create the dialog to return to the user
        let dialog = IntentDialog("You have booked a total of \(formattedHours) hours this week. You need to work an average of \(formattedAvgHoursPerDay) hours per day to meet your monthly goal of \(formattedMonthlyThreshold) hours.")
        
        // Return the total hours this week as the result value
        return .result(value: totalHoursThisWeek, dialog: dialog)
    }
}
