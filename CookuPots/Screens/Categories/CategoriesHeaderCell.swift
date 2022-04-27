//
//  CategoriesHeaderCell.swift
//  CookuPots
//
//  Created by Sebulla on 08/04/2022.
//
import UIKit
import QuartzCore

class Header: UICollectionReusableView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.frame = bounds
        label.font = UIFont(name: "GillSans", size: 25)
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = .systemPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(title: String) {
        label.text = title
    }
    func setupView() {
        addSubview(label)
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2.5).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2.5).isActive = true
    }
}
