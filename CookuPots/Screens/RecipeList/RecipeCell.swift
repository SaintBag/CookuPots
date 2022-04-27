//
//  File.swift
//  CookuPots
//
//  Created by Sebulla on 28/03/2022.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HoeflerText-Regular", size: 16)
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRecipeTitleLabel(title: String) {
        recipeTitleLabel.text = title
    }
    
    private func setConstrains() {
        
        contentView.addSubview(recipeImageView)
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        recipeImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        recipeImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 16/9).isActive = true
        
        contentView.addSubview(recipeTitleLabel)
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        recipeTitleLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20).isActive = true
        recipeTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        recipeTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
    }
}
