//
//  SavedVC.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit

class SavedVC: BaseViewController {
    
    var viewModel: SavedUsersViewModelProtocol!
    var router: Router!
    
    enum Route: String {
        case editUser
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupVM()
    }
    
    fileprivate func setupViews() {
        noDataLabel.text = "No saved users"
    }
    
    fileprivate func setupVM() {
        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.updateDataLabel = { [weak self] in
            DispatchQueue.main.async {
                let isShow = self?.viewModel.isNoData ?? false
                self?.tableView.backgroundView = isShow ? self?.noDataLabel : nil
            }
        }
        
        viewModel.fetchUsers()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        cell.userCellViewModel = viewModel.getUserCellViewModel(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.userPressed(at: indexPath)
        router.route(to: Route.editUser.rawValue, from: self, parameters: viewModel.selectedUser)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        let item = usersFetchedResultsController.object(at: indexPath)
//        managedObjectContext.delete(item)
//        managedObjectContext.saveChanges()
    }

}
