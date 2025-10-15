import AppIntents
import Foundation
import OSLog

struct MonthlyTimeEntries: AppIntent {
    
    static let title: LocalizedStringResource = "Get how many hours did I work this month"
    static let description = IntentDescription("Returns the number of hours of work this month.")
    static let openAppWhenRun: Bool = false

    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog & ReturnsValue<Double> {
        Logger.intentLogging.debug("[MonthlyTimeEntries] Performing intent")
        let timeEntriesProvider = RedmineTimeEntriesProvider()
        
        // Fetch the time entries from Redmine
        do {
            try await timeEntriesProvider.fetchTimeEntries()
        } catch {
            Logger.intentLogging.debug("[MonthlyTimeEntries] Unable to fetch Redmine entries.")
            throw EHMIntentError.redmineFetchError
        }
        
        // Get time entries for the current week using the utility method
        let timeEntriesThisMonth = TimeEntryUtils.timeEntriesForCurrentMonth(timeEntriesProvider.timeEntries)
        
        // Calculate total hours worked this week
        let totalHoursThisMonth = timeEntriesThisMonth.reduce(0) { total, entry in
            total + entry.hours
        }

        // Format the hours for display
        let formattedHours = TimeEntryUtils.formatHours(totalHoursThisMonth)
        
        // Create the dialog to return to the user
        let dialog = IntentDialog("You have booked a total of \(formattedHours) hours this month.")
        
        // Return the total hours this week as the result value
        return .result(value: totalHoursThisMonth, dialog: dialog)
    }
}
