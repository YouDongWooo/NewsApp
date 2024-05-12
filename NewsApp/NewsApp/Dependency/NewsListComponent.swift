//
//  NewsListComponent.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import UIKit
import NeedleFoundation

protocol NewsListDependency: Dependency {
    var network: NetworkServiceType { get }
    var imageLoader: ImageLoadType { get }
}

protocol NewsListBuilder {
    var newsListView: UIViewController { get }
}

class NewsListComponent: Component<NewsListDependency>, NewsListBuilder {
    var newsListView: UIViewController {
        let vc = NewsListViewController(viewModel: viewModel, imageLoader: dependency.imageLoader)
        
        return UINavigationController(rootViewController: vc)
    }
    
    var viewModel: NewsListViewModel {
        .init(listUseCase: useCase)
    }
    
    var useCase: NewsListUseCase {
        DefaultNewsListUseCase(repository: repository)
    }
    
    var repository: NewsListRepository {
        DefaultNewsListRepository(network: dependency.network)
    }
}
