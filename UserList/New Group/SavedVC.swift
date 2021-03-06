//
//  SavedVC.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit

class SavedVC: BaseViewController {
    
    let managedObjectContext = CoreDataStack.managedObjectContex
    lazy var usersFetchedResultsController: UsersFetchedResultsController = {
        return UsersFetchedResultsController(managedObjectContext: self.managedObjectContext, tableView: self.tableView, label: self.noDataLabel)
    }()
    
    let segueIdentifier: String = "ShowEditUser2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noDataLabel.text = "No saved users"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = usersFetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        cell.initCell2(user: usersFetchedResultsController.object(at: indexPath))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditUserProfileModuleBuilder().create(with: usersFetchedResultsController.object(at: indexPath))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = usersFetchedResultsController.object(at: indexPath)
        managedObjectContext.delete(item)
        managedObjectContext.saveChanges()
    }

}
