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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
       
    }
        func setupViews() {
            
            contentView.addSubview(categoriesImage)
            categoriesImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            categoriesImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            categoriesImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            categoriesImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
