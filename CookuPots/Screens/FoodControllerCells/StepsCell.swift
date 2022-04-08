//
//  StepsCell.swift
//  CookuPots
//
//  Created by Sebulla on 07/04/2022.
//

import UIKit
import Kingfisher

class StepsCell: UICollectionViewCell {
    var instructions: [Step] = []
    // TODO: Check possibilities to use one code for labels???
    let stepLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .gray
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HoeflerText-Regular", size: 16)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .gray
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HoeflerText-Regular", size: 16)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        setUpViews()
    }
    
    func setTitle(title: String) {
        stepLabel.text = title
        
    }
    
    func setUpViews() {
        
        addSubview(stepLabel)
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        stepLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stepLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stepLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        stepLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 12).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
