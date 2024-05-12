//
//  NetworkService.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import Foundation
import Combine

protocol NetworkServiceType {
    func request(api: APIType) -> AnyPublisher<Data, Error>
}

class NetworkService: NetworkServiceType {
    private let session = URLSession.shared
    
    func request(api: APIType) -> AnyPublisher<Data, Error> {
        guard let urlReq = api.url else {
            return Fail(error: NetworkError.urlConfigError)
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: urlReq)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse else {
                    throw NetworkError.unknown
                }
                
                guard (200...299).contains(response.statusCode) else {
                    throw NetworkError.responseError(statusCode: response.statusCode)
                }
                
                return element.data
            }
            .eraseToAnyPublisher()
    }
}
