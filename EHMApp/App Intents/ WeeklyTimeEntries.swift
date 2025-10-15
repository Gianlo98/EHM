import AppIntents
import Foundation
import OSLog

struct WeeklyTimeEntries: AppIntent {
    
    static let title: LocalizedStringResource = "Get how many hours did I work this week"
    static let description = IntentDescription("Returns the number of hours of work this week.")
    static let openAppWhenRun: Bool = false

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

        // Format the hours for display
        let formattedHours = TimeEntryUtils.formatHours(totalHoursThisWeek)
        
        // Create the dialog to return to the user
        let dialog = IntentDialog("You have booked a total of \(formattedHours) hours this week.")
        
        // Return the total hours this week as the result value
        return .result(value: totalHoursThisWeek, dialog: dialog)
    }
}
