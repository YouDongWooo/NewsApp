//
//  DefaultNewsListRepository.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import Foundation
import Combine

final class DefaultNewsListRepository: NewsListRepository {
    private let network: NetworkServiceType
    
    init(network: NetworkServiceType) {
        self.network = network
    }
    
    func fetchNewsList(page: Int) -> AnyPublisher<NewsListModel, Error> {
        return network
            .request(api: NewsListAPI.list(page: page))
            .decode(type: NewsListResponseDTO.self, decoder: JSONDecoder())
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
