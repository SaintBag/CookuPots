//
//  RecipeInstructionCell.swift
//  CookuPots
//
//  Created by Sebulla on 04/04/2022.
//

import UIKit

class RecipeInstructionCell: UICollectionViewCell {
    
     var instructions: [Step] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    let RecipeCell = "RecipeCell"
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        
        addSubview(tableView)
        setUpViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init is not done")
    }
    
    func setUpViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeInstructionTableViewCell.self, forCellReuseIdentifier: RecipeCell)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": tableView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": tableView]))
    }
}

extension RecipeInstructionCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instructions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell, for: indexPath) as! RecipeInstructionTableViewCell
        cell.label.text = instructions[indexPath.row].step
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class RecipeInstructionTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // creating a label to display text
    let label: UILabel = {
        let label = UILabel()
        //label.text = "test"
        label.textAlignment = .center
        label.font = UIFont(name: "Papyrus-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    func setUpViews() {
        addSubview(label)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":label]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":label]))
    }
}
