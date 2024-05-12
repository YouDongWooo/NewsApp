//
//  NewsListUseCase.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import Foundation
import Combine

protocol NewsListUseCase {
    func fetchNewsList(page: Int) -> AnyPublisher<NewsListModel, Error>
}

class DefaultNewsListUseCase: NewsListUseCase {
    private let repository: NewsListRepository
    
    init(repository: NewsListRepository) {
        self.repository = repository
    }
    
    func fetchNewsList(page: Int) -> AnyPublisher<NewsListModel, Error> {
        return repository.fetchNewsList(page: page)
    }
}
