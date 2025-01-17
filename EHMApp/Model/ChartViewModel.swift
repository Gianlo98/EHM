import SwiftUI

@MainActor
class ChartViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var hourlyWage: Double = 0
    @Published var monthHours: Double = 0
    @Published var workingDaysLeft: Int = 0
    @Published var averageHoursPerDay: Double = 0
    @Published var monthlyThreshold: Double = 0
    @Published var groupedTimeEntries: [GroupedTimeEntry] = []
    @Published var summedTimeEntries: [GroupedTimeEntry] = []
    
    private let timeEntriesService: TimeEntriesService
    
    init(service: TimeEntriesService) {
        self.timeEntriesService = service
    }
    
    func fetchData() async {
        isLoading = true
        do {
            let statistics = try await timeEntriesService.fetchAndComputeStatistics()
            
            // Update statistics
            self.workingDaysLeft = statistics.daysLeft
            self.averageHoursPerDay = statistics.avgHoursPerDay
            
            // Update other data
            self.summedTimeEntries = timeEntriesService.timeEntriesProvider.summedTimeEntries
            self.groupedTimeEntries = timeEntriesService.timeEntriesProvider.groupedTimeEntries
            self.monthHours = self.summedTimeEntries.last?.value ?? 0.0
            self.hourlyWage = DataStorage.shared.loadKey(key: .hourlyIncome)
            self.monthlyThreshold = DataStorage.shared.loadKey(key: .monthlyHourThreshold)
            
            DataStorage.shared.saveWidgetData(entry: EHMWidgetEntry(
                date: Date(),
                groupedTimeEntries: self.groupedTimeEntries,
                averageHoursPerDay: self.averageHoursPerDay,
                workingDaysLeft: self.workingDaysLeft,
                monthHours: self.monthHours
            ))
        } catch {
            print("Error fetching data: \(error)")
        }
        isLoading = false
    }
}
