//
//  PaddingItemCell.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import UIKit
import PinLayout
import FlexLayout

final class PaddingItemCell: UITableViewCell {
    static let identifier = "PaddingItemCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        upaateLayout()
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
        
    }
    
    func config(height: CGFloat) {
        contentView.flex.height(height)
        
        setNeedsLayout()
    }
}
