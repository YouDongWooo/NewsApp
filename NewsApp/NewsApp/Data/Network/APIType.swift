//
//  APIType.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol APIType {
    var baseUrl: String { get }
    var path: String { get }
    var parameter: [String: Any] { get }
    var headers: [String: String] { get }
    var method: HTTPMethod { get }
}

extension APIType {
    var headers: [String: String] { [:] }
    
    var url: URLRequest? {
        let path = baseUrl + path
        
        var query: [String] = []
        
        for (key, value) in parameter {
            let keyString = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let valueString = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            query.append("\(keyString)=\(valueString)")
        }
        
        let queryStr = query.joined(separator: "&")
        
        guard var components = URLComponents(string: path) else { return nil }
        
        components.query = queryStr
        
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}
