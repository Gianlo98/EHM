//
//  RelativeBarChart.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import Foundation
import SwiftUI
import Charts

struct RelativeBarChart: View {
    @Binding var chartData: [GroupedTimeEntry]
    

    var body: some View {
        VStack {
            // Chart showing grouped time entries
            Chart(chartData, id: \.date) { element in
                BarMark(
                    x: .value("Date", element.date, unit: .day),
                    y: .value("Hours", element.value)
                )
                .accessibilityLabel(element.date.formatted(date: .complete, time: .omitted))
                .foregroundStyle(getElementColor(element: element))
                
                // RuleMark for average line
                RuleMark(y: .value("Average", getAverage(data: chartData)))
                    .lineStyle(StrokeStyle(lineWidth: 1.5, dash: [4, 5]))
                    .foregroundStyle(.gray)
                    .annotation(position: .trailing, alignment: .leading) {
                        Text("avg")
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    }
            }
            .chartYAxis {
                AxisMarks(position: .leading, values: .automatic) { value in
                    AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 1))
                    AxisValueLabel() {
                        if let intValue = value.as(Int.self) {
                            Text("\(intValue) h")
                                .font(.system(size: 10))
                        }
                    }
                }
            }
            .frame(height: 200)
            .padding(.trailing, 20)
        }
    }
}

func getElementColor(element: GroupedTimeEntry) -> Color {
    if element.value > 9 {
        return .green
    } else if element.value > 8 {
        return .blue
    } else if element.value > 4 {
        return .orange
    } else {
        return .red
    }
}

struct RelativeBarChart_Preview: PreviewProvider {
    
    @State static private var fakeData: [GroupedTimeEntry] = GroupedTimeEntry.fakeGroupedData()
    
    static var previews: some View {
        RelativeBarChart(chartData: $fakeData)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

func getAverage(data: [GroupedTimeEntry]) -> Double {
    let countTotal = data.count
    let hoursTotal = data.reduce(0) { $0 + $1.value }
    
    return hoursTotal / Double(countTotal)
}

