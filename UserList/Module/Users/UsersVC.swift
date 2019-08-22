//
//  UsersVC.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit

class UsersVC: BaseViewController {

    var viewModel: UsersViewModelProtocol!
    var router: Router!
    
    enum Route: String {
        case editUser
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupVM()
        manualRefresh()
    }
    
    fileprivate func setupViews() {
        noDataLabel.text = "No data. Pull down to refresh"
        
        let refresher = UIRefreshControl()
        refresher.backgroundColor = .white
        refresher.tintColor = UIColor.lightGray
        refresher.addTarget(self, action: #selector(reloadData), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refresher
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
        
        viewModel.updateLoadingStatus = { [weak self] in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if !isLoading { self?.tableView.refreshControl?.endRefreshing() }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        let cellVM = viewModel.getUserCellViewModel(at: indexPath)
        cell.userCellViewModel = cellVM
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.userPressed(at: indexPath)
        router.route(to: Route.editUser.rawValue, from: self, parameters: viewModel.selectedUser)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfCells - 1 {
            reloadData()
        }
    }

    @objc func reloadData() {
        viewModel.reloadData()
    }
    
    func manualRefresh() {
        if let refreshControl = self.tableView.refreshControl {
            tableView.setContentOffset(CGPoint(x: 0, y: -refreshControl.bounds.height), animated: true)
            tableView.refreshControl?.beginRefreshing()
            tableView.refreshControl?.sendActions(for: .valueChanged)
        }
    }
    
}
