//
//  CoreDataNewsListStorage.swift
//  NewsApp
//
//  Created by YouDongwoo on 2024/05/12.
//

import UIKit
import Combine
import CoreData

final class CoreDataNewsListStorage: NewsThumbnailStorage {
    private let coreDataManager: CoreDataManager
    
    private var context: NSManagedObjectContext {
        coreDataManager.persistentContainer.viewContext
    }
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func fetch(id: String) -> AnyPublisher<UIImage?, Error> {
        return Deferred {
            return Future<UIImage?, Error> { promise in
                let request: NSFetchRequest<CachedImage> = NSFetchRequest(entityName: "CachedImage")
                
                request.predicate = NSPredicate(format: "id LIKE %@", id)
                
                do {
                    let items: [CachedImage] = try self.context.fetch(request)
                    
                    guard let item = items.first else {
                        promise(.success(nil))
                        return
                    }
                    
                    promise(.success(item.image))
                }
                catch {
                    promise(.failure(NewsThumbnailStorageError.fetch))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func save(id: String, image: UIImage) {
        do {
            let thumbnailItem = CachedImage(context: self.context)
            thumbnailItem.id = id
            thumbnailItem.image = image
            
            try self.context.save()
        }
        catch {
            
        }
    }
}
