//
//  ChartView.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import SwiftUI
import Charts

struct ChartView: View {
    @StateObject var viewModel: ChartViewModel
    
#if os(iOS)
    let backgroundColor = Color(UIColor.secondarySystemBackground)
    let screenWidth = UIScreen.main.bounds.size.width
#elseif os(macOS)
    let screenWidth = NSApplication.shared.windows.first?.frame.size.width ?? 0
    let backgroundColor = Color(NSColor.white)
#endif
    
    var body: some View {
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
                        Text("Period: \(viewModel.monthHours * viewModel.hourlyWage, specifier: "%.0f .-")")
                            .font(.largeTitle.bold())
                            .padding()
                    }
                    
                    AbsoluteLineChart(chartData: $viewModel.summedTimeEntries)
                }
            }
            .padding()
            
            
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
                            Text("Hours Booked: \(viewModel.monthHours, specifier: "%.2f")")
                                .font(.title.bold())
                            Text("Days left: \(viewModel.workingDaysLeft), Avg. Hours/Day: \(viewModel.averageHoursPerDay, specifier: "%.2f")")
                                .font(.footnote.bold())
                        }.padding()
                    }
                    
                    RelativeBarChart(chartData: $viewModel.groupedTimeEntries)
                }
            }
            .padding()
        }
        .navigationTitle("Settings")
        .task {
            await viewModel.fetchData()
        }
    }
}

struct ChartView_Preview: PreviewProvider {
    static var previews: some View {
        let fakeDownloader = FakeRedmineDownloader(feature: testFeature_te04)
        let client = RedmineHTTPClient(downloader: fakeDownloader)
        let provider = RedmineTimeEntriesProvider(client: client)
        let timeEntriesService = TimeEntriesService(provider: provider)
        let viewModel = ChartViewModel(service: timeEntriesService)
        
        ChartView(viewModel: viewModel)
            .environmentObject(provider)
    }
}
