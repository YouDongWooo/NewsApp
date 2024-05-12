//
//  NewsListDataSource.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import UIKit

final class NewsListDataSource: UITableViewDiffableDataSource<NewsListSection, NewsListSectionItem> {
    override init(tableView: UITableView, cellProvider: @escaping UITableViewDiffableDataSource<NewsListSection, NewsListSectionItem>.CellProvider) {
        super.init(tableView: tableView, cellProvider: cellProvider)
        
        defaultRowAnimation = .fade
    }
    
    func updateDatasource(_ sections: [NewsListSection], withAnimation: Bool) {
        var (snapshot, isNew) = {
            let isEmpty = sections.map { $0.items }.flatMap { $0 }.isEmpty
            
            if self.snapshot().sectionIdentifiers.isEmpty == false && isEmpty == false {
                return (self.snapshot(), false)
            }
            
            var snapshot = NSDiffableDataSourceSnapshot<NewsListSection, NewsListSectionItem>()
            
            snapshot.appendSections(sections)
            
            return (snapshot, true)
        }()
        
        sections.forEach { section in
            snapshot.appendItems((isNew == true ? section.items : section.new), toSection: section)
        }
        
        apply(snapshot, animatingDifferences: true)
    }
}
