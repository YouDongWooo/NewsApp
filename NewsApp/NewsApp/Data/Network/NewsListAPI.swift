//
//  NewsListAPI.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import Foundation

enum NewsListAPI {
    case list(page: Int)
}

extension NewsListAPI: APIType {
    var baseUrl: String {
        "https://newsapi.org"
    }
    
    var path: String {
        switch self {
        case .list:
            return "/v2/top-headlines"
        }
    }
    
    var parameter: [String: Any] {
        switch self {
        case .list(let page):
            return ["page": page,
                    "country": "us",
                    "pageSize": 50,
                    "apiKey": "ef5ec37c72b847adb3f94fa48028369d"]                          
        }
    }
    
    var method: HTTPMethod {
        .get
    }
}
