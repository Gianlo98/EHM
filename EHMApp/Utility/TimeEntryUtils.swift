import Foundation



struct TimeEntryUtils {
    
    // Formats the given number of hours to two decimal places
    static func formatHours(_ hours: Double?) -> String {
        guard let hours = hours else {
            return "0.00"
        }
        return hours.formatted(.number.precision(.fractionLength(2)))
    }
    
    // Returns the number of working days in the current month (Monday to Friday)
    static func daysInCurrentMonth() -> Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: Date())!
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
        let weekdays = Set([2, 3, 4, 5, 6]) // Monday to Friday
        
        var workingDays = 0
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth),
               let weekday = calendar.dateComponents([.weekday], from: date).weekday,
               weekdays.contains(weekday) {
                workingDays += 1
            }
        }
        return workingDays
    }
    
    // Returns the number of working days that have passed in the current month up to today
    static func workingDaysPassedInMonth() -> Int {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: Date())))!
        let today = calendar.startOfDay(for: Date())
        let weekdays = Set([2, 3, 4, 5, 6]) // Monday to Friday
        
        let daysElapsed = calendar.dateComponents([.day], from: startOfMonth, to: today).day!
        var workingDays = 0
        
        for day in 0...daysElapsed {
            if let date = calendar.date(byAdding: .day, value: day, to: startOfMonth),
               let weekday = calendar.dateComponents([.weekday], from: date).weekday,
               weekdays.contains(weekday) {
                workingDays += 1
            }
        }
        return workingDays
    }
    
    // Calculates the average number of hours per day needed to reach the monthly threshold
    static func getAverageHoursPerDayToReachMonthlyThreshold(monthlyThreshold: Double, monthHours: Double) -> (daysLeft: Int, avgHoursPerDay: Double) {
        let totalDaysInMonth = daysInCurrentMonth()
        let workingDaysPassed = workingDaysPassedInMonth()
        let workingDaysLeft = totalDaysInMonth - workingDaysPassed
        
        let hoursRemaining = max(monthlyThreshold - monthHours, 0)
        
        // Avoid division by zero: Return (workingDaysLeft, 0.0) if there are no working days left
        let averageHoursPerDay = workingDaysLeft > 0 ? Double(hoursRemaining) / Double(workingDaysLeft) : 0.0
        
        return (daysLeft: workingDaysLeft, avgHoursPerDay: averageHoursPerDay)
    }
    
    // Returns the number of working days in the current week (Monday to Friday)
    static func daysInCurrentWeek() -> Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let weekInterval = calendar.dateInterval(of: .weekOfMonth, for: today)!
        let weekdays = Set([2, 3, 4, 5, 6]) // Monday to Friday
        
        var workingDays = 0
        let startOfWeek = calendar.startOfDay(for: weekInterval.start)
        
        // Loop through the days of the current week
        for day in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: day, to: startOfWeek),
               let weekday = calendar.dateComponents([.weekday], from: date).weekday,
               weekdays.contains(weekday),
               date <= today {  // Ensure we count only up to today
                workingDays += 1
            }
        }
        
        return workingDays
    }
    
    /// Returns the time entries filtered for the current week (Monday to Sunday).
    /// - Parameters:
    ///   - timeEntries: The list of time entries to filter.
    ///   - calendar: The calendar used for date calculations.
    /// - Returns: An array of `TimeEntry` objects that occurred in the current week.
    static func timeEntriesForCurrentWeek(_ timeEntries: [RedmineTimeEntry], calendar: Calendar = .current) -> [RedmineTimeEntry] {
        let today = Date()
        
        // Get the start and end dates of the current week
        guard let weekInterval = calendar.dateInterval(of: .weekOfMonth, for: today) else {
            return []
        }
        let startOfWeek = weekInterval.start
        let endOfWeek = weekInterval.end
        
        // Filter time entries to only include those from the current week
        return timeEntries.filter { entry in
            calendar.isDate(entry.date, inSameDayAs: startOfWeek) || (entry.date >= startOfWeek && entry.date < endOfWeek)
        }
    }
    
    /// Returns the time entries filtered for the current month.
    /// - Parameters:
    ///   - timeEntries: The list of time entries to filter.
    ///   - calendar: The calendar used for date calculations.
    /// - Returns: An array of `RedmineTimeEntry` objects that occurred in the current month.
    static func timeEntriesForCurrentMonth(_ timeEntries: [RedmineTimeEntry], calendar: Calendar = .current) -> [RedmineTimeEntry] {
        let today = Date()
        
        // Get the start and end dates of the current month
        guard let monthInterval = calendar.dateInterval(of: .month, for: today) else {
            return []
        }
        let startOfMonth = monthInterval.start
        let endOfMonth = monthInterval.end
        
        // Filter time entries to only include those from the current month
        return timeEntries.filter { entry in
            calendar.isDate(entry.date, inSameDayAs: startOfMonth) || (entry.date >= startOfMonth && entry.date < endOfMonth)
        }
    }
}
