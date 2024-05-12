//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import UIKit
import PinLayout
import Then
import FlexLayout
import Combine

final class NewsListViewController: UIViewController {
    private let tableView = UITableView()
    
    private let viewModel: NewsListViewModel
    private var dataSource: NewsListDataSource?
    
    private let viewDidAppearPublisher = PassthroughSubject<Void, Never>()
    private var cancellable = Set<AnyCancellable>()
    
    let imageLoader = ImageLoader()
    
    init(viewModel: NewsListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.pin.all().marginHorizontal(10)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewDidAppearPublisher.send(())
    }
    
    private func initLayout() {
        title = "News"
        
        view.backgroundColor = .white
        
        tableView.do {
            $0.backgroundColor = .white
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = true
            
            $0.register(NewsItemCell.self, forCellReuseIdentifier: NewsItemCell.identifier)
            $0.register(PaddingItemCell.self, forCellReuseIdentifier: PaddingItemCell.identifier)
        }
        
        view.addSubview(tableView)
    }
}

extension NewsListViewController {
    private func bind() {
        bindTableView()
        
        let input = NewsListViewModel.Input(fetch: viewDidAppearPublisher.eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        
        output.sections
            .sink { [weak self] sections in
                self?.dataSource?.updateDatasource(sections, withAnimation: true)
            }
            .store(in: &cancellable)
    }
    
    private func bindTableView() {
        let dataSource = NewsListDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier -> UITableViewCell? in
            switch itemIdentifier {
            case .item(let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsItemCell.identifier, for: indexPath) as! NewsItemCell
                
                cell.config(model: model, imageLoader: self.imageLoader)
                
                return cell
                
            case .padding:
                let cell = tableView.dequeueReusableCell(withIdentifier: PaddingItemCell.identifier, for: indexPath) as! PaddingItemCell
                
                cell.config(height: 15)
                
                return cell
            }
        }
        
        self.dataSource = dataSource
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource?.itemIdentifier(for: indexPath)?.estimatedHeight ?? 0
    }
}
