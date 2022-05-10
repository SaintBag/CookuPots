//
//  CategoriesHeader.swift
//  CookuPots
//
//  Created by Sebulla on 08/04/2022.
//

import UIKit
import Kingfisher

class CategoriesCell: UICollectionViewCell {
    
    lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var categoriesNameLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.font = UIFont(name: "GillSans", size: 18)
        label.backgroundColor = .init(red: 105/105, green: 105/105, blue: 105/105, alpha: 0.7)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCategoriesNameLabel(title: String) {
        categoriesNameLabel.text = title
    }
    
    private func setupViews() {
        
        contentView.addSubview(categoryImageView)
        categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2.5).isActive = true
        categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        categoryImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(categoriesNameLabel)
        categoriesNameLabel.bottomAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: -25).isActive = true
        categoriesNameLabel.centerXAnchor.constraint(equalTo: categoryImageView.centerXAnchor).isActive = true
        categoriesNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        categoriesNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.15).isActive = true
    }
}
