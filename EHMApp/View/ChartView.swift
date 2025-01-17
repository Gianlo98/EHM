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
    @State var monthHours: Double = 0
    @State var monhtlyThreshold: Double = 0
    
#if os(iOS)
    let backgroundColor = Color(UIColor.secondarySystemBackground)
    let screenWidth = UIScreen.main.bounds.size.width
#elseif os(macOS)
    let screenWidth = NSApplication.shared.windows.first?.frame.size.width ?? 0
    let backgroundColor = Color(NSColor.white)
#endif
    
    
    var body: some View {
        let (workingDaysLeft, averageHoursPerDay) = TimeEntryUtils.getAverageHoursPerDayToReachMonthlyThreshold(
            monthlyThreshold: monhtlyThreshold,
            monthHours: monthHours
        )
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(backgroundColor))
                
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
                .frame(width: screenWidth)
                .scaledToFit()
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(backgroundColor))
                
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
                .frame(width: screenWidth)
                .scaledToFit()
            
            Spacer()
            Spacer()
        }.refreshable {
            reloadSettings()
            await fetchTimeEntries()
        }
        .task {
            reloadSettings()
            await fetchTimeEntries()
        }.onAppear {
            reloadSettings()
            NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: .main) { _ in
                reloadSettings()
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
            
            self.todayHours = self.timeEntriesProvider.groupedTimeEntries.last?.value ?? 0.0
            self.monthHours = self.timeEntriesProvider.summedTimeEntries.last?.value ?? 0.0
            
            #if DEBUG
            print("todayHours: \(self.todayHours)")
            print("monthHours: \(self.monthHours)")
            #endif
            
        } catch {
            //            self.hasError = true
        }
        isLoading = false
    }
    
    func reloadSettings() {
        self.monhtlyThreshold = UserDefaults.standard.double(forKey: "monthlyHourThreshold")
        self.hourlyWage = UserDefaults.standard.double(forKey: "hourlyIncome")
        
        
        // log values
        #if DEBUG
        print("monthlyThreshold: \(self.monhtlyThreshold)")
        print("hourlyWage: \(self.hourlyWage)")
        #endif
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
