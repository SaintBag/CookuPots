//
//  StepsCell.swift
//  CookuPots
//
//  Created by Sebulla on 07/04/2022.
//

import UIKit

class StepsCell: UICollectionViewCell {
    
    
    private lazy var recipeText: UILabel = label()
    
    private func label(withColor color: UIColor = .systemPurple) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = color
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GillSans", size: 16)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return label
    }
    
    private lazy var stepLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemPurple
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GillSans", size: 20)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(title: String) {
        stepLabel.text = title
    }
    
    func setRecipeText(text: String) {
        recipeText.text = text
    }
    
    private func setUpViews() {
        
        contentView.addSubview(stepLabel)
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        stepLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stepLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stepLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        contentView.addSubview(recipeText)
        recipeText.translatesAutoresizingMaskIntoConstraints = false
        recipeText.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 12).isActive = true
        recipeText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        recipeText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        recipeText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

}
