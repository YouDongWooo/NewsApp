//
//  NewsListModel.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import Foundation

struct NewsListModel: Decodable {
    struct Source: Decodable {
        let id: String?
        let name: String
    }
    
    struct NewsItem: Decodable, NewsIdentifiable {
        let id: String
        let title: String?
        let publishedAt: String?
        let source: Source
        let urlToImage: String?
    }
    
    let totalResults: Int
    let articles: [NewsItem]
}
