//
//  UsersFetchedResultsController.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class UsersFetchedResultsController: NSFetchedResultsController<UserEntity>, NSFetchedResultsControllerDelegate {
    
    private let tableView: UITableView
    private let noDataLabel: UILabel
    
    init(managedObjectContext: NSManagedObjectContext, tableView: UITableView, label: UILabel) {
        self.tableView = tableView
        self.noDataLabel = label
        super.init(fetchRequest: UserEntity.fetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        self.delegate = self
        
        tryFetch()
        
        showNoDataLabel()
    }
    
    func tryFetch() {
        do {
            try performFetch()
        } catch {
            print("Unresolved error: \(error.localizedDescription)")
        }
    }
    
     func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
     }
     
     func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .update, .move:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
     }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        showNoDataLabel()
    }
    
    func showNoDataLabel() {
        if let objects = self.fetchedObjects, objects.isEmpty {
            tableView.backgroundView = noDataLabel
        } else if let objects = self.fetchedObjects, !objects.isEmpty {
            tableView.backgroundView = nil
        }
    }
}
