//
//  ServiceError.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import Foundation

enum ServiceError: Error {
    case parse(String?)
    case server(String)
    case network(NetworkError)
    case etc(Error)
    case unknown
    
    var description: String { localizedDescription }
    
    var debugDescription: String? {
        switch self {
        case .parse(let detail):
            return detail
            
        case .server(let detail):
            return detail
            
        case .network(let error):
            return error.localizedDescription
            
        case .etc(let error):
            return error.localizedDescription
            
        case .unknown:
            return "unknown"
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .parse:
            return "decoding error"
            
        case .server:
            return "server error"
            
        case .network(let error):
            return error.localizedDescription
            
        case .etc:
            return "unknown error"
            
        case .unknown:
            return "unknown error"
        }
    }
}
