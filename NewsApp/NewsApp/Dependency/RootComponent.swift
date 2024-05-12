//
//  RootComponent.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import Foundation
import NeedleFoundation

class RootComponent: BootstrapComponent {
    var newsListComponent: NewsListBuilder {
        NewsListComponent(parent: self)
    }
    
    var network: NetworkServiceType {
        shared {
            NetworkService()
        }
    }
    
    var coreDataManager: CoreDataManager {
        CoreDataManager.shared
    }
}
