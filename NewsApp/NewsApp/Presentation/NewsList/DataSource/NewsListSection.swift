//
//  NewsListSection.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import Foundation

struct NewsListSection: Hashable {
    enum Section {
        case list
    }
    
    var section: Section
    var origin: [NewsListSectionItem]
    var new: [NewsListSectionItem]
    var items: [NewsListSectionItem] {
        origin + new
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(section)
    }
    
    static func == (lhs: NewsListSection, rhs: NewsListSection) -> Bool {
        return lhs.section == rhs.section
    }
}
