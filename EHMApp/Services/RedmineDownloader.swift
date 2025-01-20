//
//  Downloader.swift
//  ehm
//
//  Created by Gianlo Personal on 29.01.23.
//

import Foundation
import OSLog

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
        
        Logger.providerLogger.debug("[RedmineDownloader] Querying \(url)")
        
        // Customize timeout for the URLRequest
        var request = URLRequest(url: url, timeoutInterval: 120) // Set timeout to 120 seconds
        request.addValue(apiKey, forHTTPHeaderField: "X-Redmine-API-Key")
        request.httpMethod = "GET"
        
        // Perform the request
        let (data, response) = try await self.data(for: request, delegate: nil)
        
        guard let httpResponse = response as? HTTPURLResponse,
              validStatus.contains(httpResponse.statusCode) else {
            throw RedmineError.networkError(comment: "Request to \(url) failed with response: \(response)")
        }
        
        Logger.providerLogger.debug("Request to \(url) succeeded with status code \(httpResponse.statusCode)")
        return data
    }
}
