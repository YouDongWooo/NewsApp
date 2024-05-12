//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        ValueTransformer.setValueTransformer(UIImageTransformer(), forName: NSValueTransformerName("UIImageTransformer"))
        
        persistentContainer = NSPersistentContainer(name: "NewsApp")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError()
            }
        }
    }
}
