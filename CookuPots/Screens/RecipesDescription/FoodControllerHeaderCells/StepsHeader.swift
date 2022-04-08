//
//  StepsHeader.swift
//  CookuPots
//
//  Created by Sebulla on 07/04/2022.
//

import UIKit
import Kingfisher

class StepsHeader: UICollectionReusableView {
    
    let stepsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleColorEmoji", size: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    let stepsPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "list")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .green // TODO: to remove
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setTitle(title: String) {
        stepsLabel.text = title
        
    }
    
    func setupViews() {
        
        addSubview(stepsLabel)
        NSLayoutConstraint.activate([
            stepsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            stepsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12),
            stepsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            stepsLabel.heightAnchor.constraint(equalTo: heightAnchor),
        ])
        
        addSubview(stepsPhoto)
        NSLayoutConstraint.activate([
            stepsPhoto.widthAnchor.constraint(equalToConstant: 50),
            stepsPhoto.heightAnchor.constraint(equalToConstant: 50),
            stepsPhoto.leadingAnchor.constraint(equalTo: leadingAnchor),
            stepsPhoto.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
