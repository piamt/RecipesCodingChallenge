//
//  APIError.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import Foundation

public enum APIError: Error, LocalizedError, Equatable {
    
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case decodingError
    case unknown(Error?)
    
    static func mapStatus(_ statusCode: Int) -> APIError {
        switch statusCode {
        case 400:
            return APIError.badRequest
        case 401:
            return APIError.unauthorized
        case 403:
            return APIError.forbidden
        case 404:
            return APIError.notFound
        default:
            return  APIError.unknown(nil)   
        }
    }
    
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch(lhs, rhs) {
        case (.badRequest, .badRequest), (.unauthorized, .unauthorized), (.forbidden, .forbidden), (.notFound, .notFound), (.decodingError, .decodingError), (.unknown, .unknown):
            return true
        default: return false
        }
    }
}
