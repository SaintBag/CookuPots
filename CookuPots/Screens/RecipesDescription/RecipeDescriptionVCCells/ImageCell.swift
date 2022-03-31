//
//  ImageCell.swift
//  CookuPots
//
//  Created by Sebulla on 30/03/2022.
//

import UIKit

class ImageCell: UITableViewCell {
    
    var recipeImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(recipeImageView)
        configureImageView()
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageView() {
        recipeImageView.layer.cornerRadius = 10
        recipeImageView.clipsToBounds = true
        
    }

}
