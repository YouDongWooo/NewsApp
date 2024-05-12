//
//  NewsListRepository.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import Foundation
import Combine

protocol NewsListRepository {
    func fetchNewsList(page: Int) -> AnyPublisher<NewsListModel, Error>
}
