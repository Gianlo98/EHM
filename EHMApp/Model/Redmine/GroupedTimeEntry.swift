//
//  ChartData.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//
import Foundation

struct GroupedTimeEntry: Codable {
    var date: Date
    var value: Double
}

extension GroupedTimeEntry {
    static func fakeGroupedData() -> [GroupedTimeEntry] {
        var fakeData: [GroupedTimeEntry] = []
        
        for i in 1...30 {
            let date = Calendar.current.date(byAdding: .day, value: i * -1, to: Date())
            let value = date!.dayNumberOfWeek()! <= 5 ? Double.random(in: 2.0 ..< 12.0) : 0
            fakeData.append(GroupedTimeEntry(date: date!, value: value))
        }
        
        return fakeData
    }
    
    static func fakeSummedData() -> [GroupedTimeEntry] {
        var fakeData: [GroupedTimeEntry] = []
        
        var val: Double = 0
        for i in 1...30 {
            let date = Calendar.current.date(byAdding: .day, value: -30 + i, to: Date())
            val += date!.dayNumberOfWeek()! <= 5 ? Double.random(in: 8.0 ..< 11.0) : 0
            fakeData.append(GroupedTimeEntry(date: date!, value: val))
        }
        
        return fakeData
    }

}


