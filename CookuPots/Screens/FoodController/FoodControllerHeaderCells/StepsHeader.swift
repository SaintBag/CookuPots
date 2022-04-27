//
//  StepsHeader.swift
//  CookuPots
//
//  Created by Sebulla on 07/04/2022.
//

import UIKit
import Kingfisher

class StepsHeader: UICollectionReusableView {
    
    private lazy var stepsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GillSans", size: 25)
        label.textColor = .systemPurple
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(title: String) {
        stepsLabel.text = title
    }
    
    private func setupViews() {
        
        addSubview(stepsLabel)
        NSLayoutConstraint.activate([
            stepsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            stepsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12),
            stepsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            stepsLabel.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
}
