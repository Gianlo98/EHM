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
    
    @State private var showSelectionBar = false
    @State private var offsetX = 0.0
    @State private var offsetY = 0.0
    @State private var selectedDay = ""
    @State private var selectedMins = 0

    var body: some View {
        VStack{
            Chart (chartData, id: \.date) { element in
                BarMark(
                    x: .value("Date", element.date, unit: .day),
                    y: .value("Hours", element.value)
                )
                .accessibilityLabel(element.date.formatted(date: .complete, time: .omitted))
                .foregroundStyle(getElementColor(element: element))
                RuleMark(
                    y: .value("Average", getAverage(data: chartData))
                )
                .lineStyle(StrokeStyle(lineWidth: 1.5, dash: [4, 5]))
                
                .foregroundStyle(.gray)
                .annotation(position: .trailing, alignment: .leading) {
                    Text("avg")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
                
                
            }.chartYAxis {
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
            .chartOverlay { pr in
                GeometryReader { geoProxy in
                                        Rectangle().foregroundStyle(Color.orange.gradient)
                                            .frame(width: 2, height: geoProxy.size.height * 0.95)
                                            .opacity(showSelectionBar ? 1.0 : 0.0)
                                            .offset(x: offsetX)
                                        
                                        Capsule()
                                            .foregroundStyle(.orange.gradient)
                                            .frame(width: 100, height: 50)
                                            .overlay {
                                                VStack {
                                                    Text("\(selectedDay)")
                                                    Text("\(selectedMins) mins")
                                                        .font(.title2)
                                                }
                                                .foregroundStyle(.white.gradient)
                                            }
                                            .opacity(showSelectionBar ? 1.0 : 0.0)
                                            .offset(x: offsetX - 50, y: offsetY - 50)
                                        
                                        Rectangle().fill(.clear).contentShape(Rectangle())
                                            .gesture(DragGesture().onChanged { value in
                                                if !showSelectionBar {
                                                    showSelectionBar = true
                                                }
                                                let origin = geoProxy[pr.plotFrame!].origin
                                                let location = CGPoint(
                                                    x: value.location.x - origin.x,
                                                    y: value.location.y - origin.y
                                                )
                                                offsetX = location.x
                                                offsetY = location.y
                                                
                                                let (day, _) = pr.value(at: location, as: (String, Int).self) ?? ("-", 0)
//                                                let mins = chartData..first { w in
//                                                    w.day.lowercased() == day.lowercased()
//                                                }?.minutes ?? 0
                                                selectedDay = day
//                                                selectedMins = mins
                                            }
                                            .onEnded({ _ in
                                                showSelectionBar = false
                                            }))
                }
                
            }
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
