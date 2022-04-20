//
//  IngredientsHeader.swift
//  CookuPots
//
//  Created by Sebulla on 07/04/2022.
//

import UIKit
import Kingfisher

class IngredientsHeader: UICollectionReusableView {
    
    let recipePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    fileprivate let ingredientsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bag")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var imageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 15)
        label.backgroundColor = .init(red: 105/105, green: 105/105, blue: 105/105, alpha: 0.7)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private lazy var ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setImageTitleLabel(title: String) {
        imageTitleLabel.text = title
    }
    
    func setTitle(title: String) {
        ingredientsLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {

        addSubview(recipePhoto)
        recipePhoto.topAnchor.constraint(equalTo: topAnchor).isActive = true
        recipePhoto.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        recipePhoto.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(ingredientsLabel)
        ingredientsLabel.topAnchor.constraint(equalTo: recipePhoto.bottomAnchor).isActive = true
        ingredientsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        ingredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        ingredientsLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(ingredientsIcon)
        ingredientsIcon.translatesAutoresizingMaskIntoConstraints = false
        ingredientsIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        ingredientsIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        ingredientsIcon.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        ingredientsIcon.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(imageTitleLabel)
        imageTitleLabel.contentMode = .center
        imageTitleLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageTitleLabel.bottomAnchor.constraint(equalTo: recipePhoto.bottomAnchor, constant: -10).isActive = true
        
    }
}
