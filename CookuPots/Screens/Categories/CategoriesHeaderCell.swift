//
//  CategoriesHeaderCell.swift
//  CookuPots
//
//  Created by Sebulla on 08/04/2022.
//
import UIKit

class Header: UICollectionReusableView {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
        label.font = UIFont(name: "AppleColorEmoji", size: 16)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func setTitle(title: String) {
        label.text = title
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
