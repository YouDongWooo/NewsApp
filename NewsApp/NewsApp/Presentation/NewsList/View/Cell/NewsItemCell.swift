//
//  NewsItemCell.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import UIKit
import PinLayout
import FlexLayout
import Then

final class NewsItemCell: UITableViewCell {
    static let identifier = "NewsItemCell"
    
    private let thumbnailImageView = UIImageView()
    private let sourceLabel = UILabel()
    private let titleLabel = UILabel()
    private let publishedAtLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        upaateLayout()
    }
    
    private func initLayout() {
        sourceLabel.do {
            $0.font = .systemFont(ofSize: 10)
        }
        
        titleLabel.do {
            $0.font = .boldSystemFont(ofSize: 13)
            $0.numberOfLines = 5
        }
        
        publishedAtLabel.do {
            $0.font = .systemFont(ofSize: 10)
        }
        
        contentView.flex.direction(.column).paddingHorizontal(10).define { flex in
            flex.view?.layer.borderColor = UIColor.black.cgColor
            flex.view?.layer.borderWidth = 1
            
            flex.addItem().direction(.row).height(120).paddingTop(10).define { flex in
                flex.addItem().direction(.column).grow(1).shrink(1).alignSelf(.start).define { flex in
                    flex.addItem(sourceLabel)
                    flex.addItem(titleLabel).marginTop(5)
                }
                
                flex.addItem(thumbnailImageView).width(160).height(100).marginLeft(5).backgroundColor(.lightGray)
            }
            
            flex.addItem().height(1).backgroundColor(.gray)
            flex.addItem(publishedAtLabel)
        }
    }
    
    fileprivate func upaateLayout() {
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        
        upaateLayout()
        
        return contentView.frame.size
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.image = nil
    }
    
    func config(model: NewsListModel.NewsItem, imageLoader: ImageLoadType) {
        if let urlStr = model.urlToImage, let url = URL(string: urlStr) {
            imageLoader.loadImage(urlString: urlStr) { image in
                self.thumbnailImageView.image = image
            }
        }
        
        titleLabel.text = model.title
        sourceLabel.text = model.source.name
        publishedAtLabel.text = model.publishedAt
        
        sourceLabel.flex.markDirty()
        titleLabel.flex.markDirty()
        publishedAtLabel.flex.markDirty()
        
        setNeedsLayout()
    }
}
