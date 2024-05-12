//
//  ImageLoader.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import UIKit
import Combine
import CoreData

protocol ImageLoadType {
    func loadImage(urlString: String, _ closure: @escaping (UIImage?) -> Void )
}

class ImageLoader: ImageLoadType {
    private let network: NetworkServiceType
    private let storage: NewsThumbnailStorage
    private var cancellable: [String: AnyCancellable] = [:]
    
    init(networkService: NetworkServiceType, storage: NewsThumbnailStorage) {
        self.network = networkService
        self.storage = storage
    }
    
    func loadImage(urlString: String, _ closure: @escaping (UIImage?) -> Void ) {
        let cancellable = storage.fetch(id: urlString)
            .flatMap { [weak self] image -> AnyPublisher<UIImage, Error> in
                guard let self = self else { return Empty().eraseToAnyPublisher() }
                
                if let image = image {
                    return Future<UIImage, Error> { promise in
                        promise(.success(image))
                    }
                    .eraseToAnyPublisher()
                }
                
                return self.network.request(url: urlString)
                    .compactMap { UIImage(data: $0) }
                    .handleEvents(receiveOutput: { image in
                        self.storage.save(id: urlString, image: image)
                    })
                    .eraseToAnyPublisher()
            }
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.cancellable[urlString] = nil
                
            } receiveValue: { str in
                closure(str)
            }
        
        self.cancellable[urlString] = cancellable
    }
    
    func cancel(urlString: String) {
        cancellable[urlString]?.cancel()
    }
}
