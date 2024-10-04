//
//  APICaller.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import Foundation

class APICaller {
    
    static let shared = APICaller()
    
    func fetch<T: Codable>(endpoint: Endpoint, _ t: T.Type) async throws -> T {
        
        guard let url = endpoint.url else {
            throw APIError.unknown(nil)
        }
        
        var request: URLRequest
        switch endpoint.httpMethod {
        case .GET:
            var params = endpoint.sharedParams
            if let custom = endpoint.customParams {
                params = params.merging(custom) { (current, _) in current }
            }
            request = URLRequest(url: url.appending(queryItems: params.queryItemArray))
        case .POST:
            request = URLRequest(url: url.appending(queryItems: endpoint.sharedParams.queryItemArray))
            request.httpBody = try JSONSerialization.data(withJSONObject: endpoint.body, options: .prettyPrinted)
        }
        
        request.httpMethod = endpoint.httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let response: (data: Data, response: URLResponse) = try await URLSession.shared.data(for: request)
        
        do {
            let fetchedData = try JSONDecoder().decode(T.self, from: try mapResponse(response: response))
            return fetchedData
        } catch {
            throw APIError.decodingError
        }
    }
    
    func mapResponse(response: (data: Data, response: URLResponse)) throws -> Data {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            return response.data
        }
        
        if (200..<300).contains(httpResponse.statusCode) {
            return response.data
        } else {
            throw APIError.mapStatus(httpResponse.statusCode)
        }
    }
}
