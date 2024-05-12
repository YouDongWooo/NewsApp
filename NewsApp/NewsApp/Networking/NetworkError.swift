//
//  NetworkError.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import Foundation

enum NetworkError: Error {
    case unknown
    case urlConfigError
    case notConnected
    case timeout
    case responseError(statusCode: Int)
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "unknown error"
            
        case .urlConfigError:
            return "url config error"
            
        case .notConnected:
            return "network is not connected"
            
        case .timeout:
            return "network timeout"
            
        case .responseError(let code):
            return "response error \(code)"
        }
    }
}
