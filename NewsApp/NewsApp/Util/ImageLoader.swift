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
    private var context = CoreDataManager.shared.persistentContainer.viewContext
    
    private var cancellable: [String: AnyCancellable] = [:]
    
    func loadImage(urlString: String, _ closure: @escaping (UIImage?) -> Void ) {
        let cancellable = Deferred {
            return Future<UIImage?, Error> { promise in
                let request: NSFetchRequest<CachedImage> = NSFetchRequest(entityName: "CachedImage")
                
                request.predicate = NSPredicate(format: "id LIKE %@", urlString)
                
                do {
                    let photos: [CachedImage] = try self.context.fetch(request)
                    if let photo = photos.first {
                        promise(.success(photo.image))
                    }
                    else {
                        promise(.success(nil))
                    }
                }
                catch {
                    return
                }
            }
        }
        .flatMap { image -> AnyPublisher<UIImage, Error> in
            if let image = image {
                return Future<UIImage, Error> { promise in
                    promise(.success(image))
                }
                .eraseToAnyPublisher()
            }
            
            let url = URL(string: urlString)!
            
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { element -> Data in
                    guard let response = element.response as? HTTPURLResponse else {
                        throw NetworkError.unknown
                    }
                    
                    guard (200...299).contains(response.statusCode) else {
                        throw NetworkError.responseError(statusCode: response.statusCode)
                    }
                    
                    return element.data
                }
                .compactMap { UIImage(data: $0) }
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
