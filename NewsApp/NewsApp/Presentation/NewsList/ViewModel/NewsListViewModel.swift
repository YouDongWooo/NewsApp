//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import Foundation
import Combine

class NewsListViewModel: ViewModelType {
    struct Input {
        var fetch: AnyPublisher<Void, Never>
    }
    
    struct Output {
        var sections: AnyPublisher<[NewsListSection], Never>
    }
    
    private let listUseCase: NewsListUseCase
    private var cancellable = Set<AnyCancellable>()
    
    var sections: [NewsListSection] = []
    var focusNewsIndex: IndexPath?
    var error: ServiceError?
    
    init(listUseCase: NewsListUseCase) {
        self.listUseCase = listUseCase
    }
    
    func transform(input: Input) -> Output {
        let sectionPublisher = PassthroughSubject<[NewsListSection], Never>()
        
        input.fetch
            .flatMap { [weak self] _ -> AnyPublisher<NewsListModel, Error> in
                guard let self = self else { return Empty().eraseToAnyPublisher() }
                
                return self.listUseCase.fetchNewsList(page: 1)
            }
            .sink { _ in
                
            } receiveValue: { [weak self] model in
                guard let self = self else { return }
                
                let originItems = self.sections.first?.items ?? []
                let originList = originItems.compactMap { item in
                    switch item {
                    case .item(let model): return model
                    case .padding: return nil
                    }
                }
                let allList = originList + model.articles
                
                sectionPublisher.send([makeSection(originItems, model.articles)])
            }
            .store(in: &cancellable)
        
        return Output(sections: sectionPublisher.eraseToAnyPublisher())
    }
}

extension NewsListViewModel {
    private func makeSection(_ originItems: [NewsListSectionItem], _ newList: [NewsListModel.NewsItem]) -> NewsListSection {
        var newItems: [NewsListSectionItem] = {
            guard newList.count > 0 else { return [] }
            
            return (0 ..< 2 * newList.count - 1)
                .map { i in
                    return i % 2 == 0 ? .item(newList[i / 2])
                                      : .padding(UUID())
                }
        }()
        
        if originItems.isEmpty == false {
            newItems.insert(.padding(UUID()), at: 0)
        }
        
        return .init(section: .list, origin: originItems, new: newItems)
    }
}
