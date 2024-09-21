//
//  ChartView.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import SwiftUI
import Charts


struct ChartView: View {
    
    @EnvironmentObject var timeEntriesProvider: RedmineTimeEntriesProvider
    
    @State var isLoading: Bool = false
    
    @State var hourlyWage: Double = 0
    @State var todayHours: Double = 0
    @State var monthHours: Double = 160
    @State var monhtlyThreshold: Double = UserDefaults.standard.double(forKey: "monthlyHourThreshold")
    
    var body: some View {
        let (workingDaysLeft, averageHoursPerDay) = TimeEntryUtils.getAverageHoursPerDayToReachMonthlyThreshold(
            monthlyThreshold: monhtlyThreshold,
            monthHours: monthHours
        )
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(UIColor.secondarySystemBackground))
                
                VStack {
                    HStack {
                        Text("🏦 ")
                            .font(.largeTitle.bold())
                            .padding(.leading, 20)
                        Spacer()
                        Text("Period: \(monthHours * hourlyWage, specifier: "%.0f .-")")
                            .font(.largeTitle.bold())
                            .padding()
                    }
                    
                    AbsoluteLineChart(chartData: $timeEntriesProvider.summedTimeEntries)
                }
            }.padding()
                .frame(width: UIScreen.main.bounds.size.width)
                .scaledToFit()
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(UIColor.secondarySystemBackground))
                
                VStack {
                    HStack {
                        Text("📅")
                            .font(.largeTitle.bold())
                            .padding(.leading, 20)
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Hours booked: \(monthHours, specifier: "%.2f")")
                                .font(.title.bold())
                            Text("Days left: \(workingDaysLeft), Avg. Hours/Day: \(averageHoursPerDay, specifier: "%.2f")")
                                .font(.footnote.bold())
                        }.padding()
                    }
                    
                    RelativeBarChart(chartData:  $timeEntriesProvider.groupedTimeEntries)
                }
            }.padding()
                .frame(width: UIScreen.main.bounds.size.width)
                .scaledToFit()
            
            Spacer()
            Spacer()
        }.refreshable {
            await fetchTimeEntries()
        }.task {
            await fetchTimeEntries()
        }.onAppear() {
            NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: .main) { _ in
                self.monhtlyThreshold = UserDefaults.standard.double(forKey: "monthlyHourThreshold")
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
        }
    }
    
}




extension ChartView {
    func getCurrentMonth() -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: Date.now)
    }
    
    func fetchTimeEntries() async {
        isLoading = true
        do {
            try await timeEntriesProvider.fetchTimeEntries()
            
            self.hourlyWage = UserDefaults.standard.double(forKey: "hourlyIncome")
            self.todayHours = self.timeEntriesProvider.groupedTimeEntries.last?.value ?? 0.0
            self.monthHours = self.timeEntriesProvider.summedTimeEntries.last?.value ?? 0.0
        } catch {
            //            self.hasError = true
        }
        isLoading = false
    }
}




struct ChartView_Preview: PreviewProvider {
    static var previews: some View {
        let fakeDownloader = FakeRedmineDownloader(feature: testFeature_te04)
        let client = RedmineHTTPClient(downloader: fakeDownloader)
        
        ChartView()
            .environmentObject(RedmineTimeEntriesProvider(client: client))
    }
}
