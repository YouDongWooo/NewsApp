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

final class NewsListViewController: UIViewController {
    private let tableView = UITableView()
    
    private var dataSource: NewsListDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.pin.all().marginHorizontal(10)
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
    private func bindTableView() {
        let dataSource = NewsListDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier -> UITableViewCell? in
            switch itemIdentifier {
            case .item(let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: NewsItemCell.identifier, for: indexPath) as! NewsItemCell
                
                cell.config(model: model)
                
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
