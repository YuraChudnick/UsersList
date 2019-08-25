//
//  DeselectAnimatable.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/22/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

protocol DeselectAnimatable {
    func deselectRow(in tableView: UITableView, animated: Bool)
}

extension DeselectAnimatable where Self: UIViewController {
    
    func deselectRow(in tableView: UITableView, animated: Bool) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            if let coordinator = transitionCoordinator {
                coordinator.animate(alongsideTransition: { context in
                    tableView.deselectRow(at: selectedIndexPath, animated: true)
                }) { context in
                    if context.isCancelled {
                        tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
                    }
                }
            } else {
                tableView.deselectRow(at: selectedIndexPath, animated: animated)
            }
        }
    }
    
}
