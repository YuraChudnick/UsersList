//
//  UsersVC.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit

class UsersVC: BaseViewController, UsersViewProtocol {

    private var usersList: [User] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var presenter: UsersPresenter!
    let segueIdentifier: String = "ShowEditUser"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noDataLabel.text = "No data. Pull down to refresh"
        setupRefreshControl()
        manualRefresh()
    }
    
    fileprivate func setupRefreshControl() {
        let refresher = UIRefreshControl()
        refresher.backgroundColor = .white
        refresher.tintColor = UIColor.lightGray
        refresher.addTarget(self, action: #selector(getData), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refresher
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        cell.initCell(user: usersList[indexPath.row])
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(EditUserProfileModuleBuilder().create(with: usersList[indexPath.row]), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == usersList.count - 1 {
            getData()
        }
    }

    @objc func getData() {
        presenter.didRefreshUsersList()
    }
    
    func manualRefresh() {
        if let refreshControl = self.tableView.refreshControl {
            tableView.setContentOffset(CGPoint(x: 0, y: -refreshControl.bounds.height), animated: true)
            tableView.refreshControl?.beginRefreshing()
            tableView.refreshControl?.sendActions(for: .valueChanged)
        }
    }
    
    func setUsersList(list: [User]) {
        usersList = list
    }
    
    func stopRefreshing() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func showHideNoDataLabel(show: Bool) {
        tableView.backgroundView = show ? noDataLabel : nil
    }
    
}
