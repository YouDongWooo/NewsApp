//
//  NewsListSectionItem.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import Foundation

enum NewsListSectionItem: Hashable {
    case item(NewsListModel.NewsItem)
    case padding(UUID)
    
    var estimatedHeight: CGFloat {
        switch self {
        case .item: return 70
        case .padding: return 15
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .item(let model):
            hasher.combine(model.id)
            
        case .padding(let id):
            hasher.combine(id)
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.item(let lModel), .item(let rModel)):
            return lModel.id == rModel.id
            
        default:
            return false
        }
    }
}
