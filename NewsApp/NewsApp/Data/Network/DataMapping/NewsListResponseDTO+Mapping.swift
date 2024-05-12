//
//  NewsListResponseDTO+Mapping.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import Foundation

struct NewsListResponseDTO: Decodable {
    struct Source: Decodable {
        let id: String?
        let name: String
    }
    
    struct NewsItem: Decodable {
        let title: String?
        let description: String?
        let author: String?
        let publishedAt: String?
        let source: Source
        let urlToImage: String?
        let content: String?
    }
    
    let totalResults: Int
    let articles: [NewsItem]
}

extension NewsListResponseDTO {
    func toDomain() -> NewsListModel {
        return .init(totalResults: totalResults,
                     articles: articles.map { $0.toDomain() })
    }
}

extension NewsListResponseDTO.Source {
    func toDomain() -> NewsListModel.Source {
        return .init(id: id, name: name)
    }
}

extension NewsListResponseDTO.NewsItem {
    func toDomain() -> NewsListModel.NewsItem {
        return .init(id: UUID().uuidString,
                     title: title,
                     publishedAt: publishedAt,
                     source: source.toDomain(),
                     urlToImage: urlToImage)
    }
}
