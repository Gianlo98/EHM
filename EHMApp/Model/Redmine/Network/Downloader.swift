//
//  Downloader.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import KeychainSwift


let validStatus = 200...299

protocol RedmineDownloader {
    func fetch(from: URL) async throws -> Data
}

extension URLSession: RedmineDownloader {
    func fetch(from url: URL) async throws -> Data {
        
        let keychain = KeychainSwift()
        guard let apiKey = keychain.get("redmineApiKey") else {
            throw RedmineError.missingCredentials
        }
        
        var request = URLRequest(url: url ,timeoutInterval: Double.infinity)
        request.addValue(apiKey, forHTTPHeaderField: "X-Redmine-API-Key")

        request.httpMethod = "GET"
        guard let (data, response) = try await self.data(for: request, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw RedmineError.networkError(comment: "Request to \(url) went wrong")
        }
        
        return data
    }
}
