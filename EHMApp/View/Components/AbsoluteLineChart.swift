//
//  MonthlyLineChart.swift
//  ehm
//
//  Created by Gianlo Personal on 30.01.23.
//
import Foundation
import SwiftUI
import Charts

struct AbsoluteLineChart: View {
    @Binding var chartData: [GroupedTimeEntry]
    
    @State private var lineWidth = 2.0
    @State private var chartColor: Color = .blue
    @State private var showSymbols = false
    @State private var fixedCosts: Double = 0
    @State private var hourlyIncome: Double = 0
    
    var body: some View {
        let maxValue = chartData.max(by: { $0.value < $1.value })?.value ?? 0
        let yAxisUpperBound = nextMultipleOfFiveThousand(after: Int(maxValue * hourlyIncome))

        Chart {
            ForEach(chartData, id: \.date) { element in
                LineMark(
                    x: .value("Date", element.date, unit: .day),
                    y: .value("Hours", element.value * hourlyIncome)
                )
                .accessibilityLabel(element.date.formatted(date: .complete, time: .shortened))
                .lineStyle(StrokeStyle(lineWidth: lineWidth))
                .foregroundStyle(chartColor.gradient)
                .interpolationMethod(.cardinal)
            }
            
            if fixedCosts != 0 {
                RuleMark(
                    y: .value("F", fixedCosts)
                )
                .lineStyle(StrokeStyle(lineWidth: 1.5, dash: [4, 5]))
                .foregroundStyle(.gray)
                .annotation(position: .top, alignment: .trailing) {
                    Text("Fixed costs")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                        .fontWeight(.bold)
                }
            }
            
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: .automatic) { value in
                AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 1))
                AxisValueLabel() {
                    if let val = value.as(Double.self) {
                        Text("\(val, specifier: "%.0f .-")")
                            .font(.system(size: 10))
                    }
                }
            }
        }
        .chartYScale(domain: 0...yAxisUpperBound)
        .frame(height: 200)
        .padding()
        .refreshable {
            reloadSettings()
        }
        .task {
            reloadSettings()
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
    
    func nextMultipleOfFiveThousand(after value: Int) -> Int {
        return ((value / 5000) + (value % 5000 > 0 ? 1 : 0)) * 5000
    }
}

extension AbsoluteLineChart {
    
    func reloadSettings() {
        self.fixedCosts = UserDefaults.standard.double(forKey: "fixedCostThreshold")
        self.hourlyIncome = UserDefaults.standard.double(forKey: "hourlyIncome")
        
        
        // log values
        #if DEBUG
        print("fixedCosts: \(self.fixedCosts)")
        print("hourlyIncome: \(self.hourlyIncome)")
        #endif
    }
}

struct AbsoluteLineChart_Preview: PreviewProvider {
    
    @State static private var fakeData: [GroupedTimeEntry] = GroupedTimeEntry.fakeSummedData()
    
    static var previews: some View {

        AbsoluteLineChart(chartData: $fakeData)
            .padding()
            .previewLayout(.sizeThatFits)
            .onAppear() {
                UserDefaults.standard.set(0, forKey: "fixedCostThreshold")
                UserDefaults.standard.set(0, forKey: "hourlyIncome")
            }
    }
}


