//
//  ImageCell.swift
//  CookuPots
//
//  Created by Sebulla on 04/04/2022.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
     let recipePhoto: UIImageView = {
        let imageView = UIImageView()
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
        
        contentView.addSubview(recipePhoto)
        recipePhoto.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        recipePhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        recipePhoto.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        recipePhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
