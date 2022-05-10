//
//  ShoppingListVC.swift
//  CookuPots
//
//  Created by Sebulla on 11/04/2022.
//

import UIKit
import CoreData

final class ShoppingListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    typealias Dependencies = HasDataController
    
    private let dependencies: Dependencies
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ShoppingListCell.self, forCellReuseIdentifier: "cellId")
        return table
    }()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping List"
        setupAddButton()
        configureTableView()
        performFetch()
    }
    
    private func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    private lazy var fetchedResultsController: NSFetchedResultsController<SHIngredient> = {
        
        let fetchRequest: NSFetchRequest<SHIngredient> = SHIngredient.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dependencies.dataController.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    private func setupAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc func didTapAdd() {
        
        let alert = UIAlertController(title: "Add ingredient", message: "Add what else do you need", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.dependencies.dataController.createIngredient(name: text)
        }))
        present(alert, animated: true)
    }
    
   private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.pinView(to: view)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }
    
   private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        if sectionInfo.numberOfObjects > 0 {
            
            return sectionInfo.numberOfObjects
            
        } else {
             
            let image = UIImage(named: "CookUPots")
            let imageForEmptyRows = UIImageView(image: image)
            imageForEmptyRows.contentMode = .scaleAspectFit
            tableView.backgroundView = imageForEmptyRows
            tableView.separatorStyle = .none
            
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? ShoppingListCell else { return UITableViewCell() }
        
        let object = self.fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = object.name
        cell.removeFromCartAction = {
            
            print("try to remove \(object.name)")
            do {
                try self.dependencies.dataController.delete(ingredient: object)
                
            } catch(let error) {
                print(error)
            }
        }
        return cell
    }
}

extension ShoppingListVC: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        @unknown default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
