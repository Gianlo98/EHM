//
//  FakeHTTPClient.swift
//  ehmTests
//
//  Created by Gianlo Personal on 29.01.23.
//

import Foundation

class FakeRedmineDownloader: RedmineDownloader {
    let feature: Data
    
    func fetch(from: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        
        if from.absoluteString.contains("current.json") {
            return testUser
        }
        
        
        return feature
    }
    
    init(feature: Data = testFeature_te02) {
        self.feature = feature
    }
}
