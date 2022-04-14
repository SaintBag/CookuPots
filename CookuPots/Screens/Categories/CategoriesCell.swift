//
//  CategoriesHeader.swift
//  CookuPots
//
//  Created by Sebulla on 08/04/2022.
//

import UIKit
import Kingfisher

class CategoriesCell: UICollectionViewCell {
    
    var data: CustomData? {
        didSet {
            guard let data = data else { return }
            categoriesImage.image = data.image
        }
    }
    
    fileprivate let categoriesImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "breakfast")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var categoriesNameLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.text = "Here you will find ingredients soon..."
        label.font = UIFont(name: "HoeflerText-Regular", size: 18)
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
        
        contentView.addSubview(categoriesImage)
        categoriesImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        categoriesImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        categoriesImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        categoriesImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(categoriesNameLabel)
        categoriesNameLabel.contentMode = .center
        categoriesNameLabel.bottomAnchor.constraint(equalTo: categoriesImage.bottomAnchor, constant: -15).isActive = true
        categoriesNameLabel.centerXAnchor.constraint(equalTo: categoriesImage.centerXAnchor).isActive = true
        categoriesNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        categoriesNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
