//
//  UsersVC.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class UsersVC: BaseViewController {
    
    var userList: [User] = []
    let segueIdentifier: String = "ShowEditUser"
    let refresher = UIRefreshControl()

    var page: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noDataLabel.text = "No data. Pull down to refresh"
        
        refresher.backgroundColor = .white
        refresher.tintColor = UIColor.lightGray
        refresher.addTarget(self, action: #selector(getData), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refresher

        manualRefresh()
        //getData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        cell.initCell(user: userList[indexPath.row])
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: userList[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = userList.count - 1
        if indexPath.row == lastItem {
            page += 1
            print(page)
            getData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueIdentifier, let data = sender as? User {
            let vc = segue.destination as! EditUserProfileVC
            vc.user = data
            vc.hidesBottomBarWhenPushed = true
        }
        
    }

    @objc func getData() {
        Alamofire.request(UserListRouter.pagination(page: page, quantity: 10)).responseObject { (response: DataResponse<UserList>) in
            self.tableView.refreshControl?.endRefreshing()
            response.result.value.map({ (data) in
                print(data)
                self.userList = self.userList + data.results
                self.tableView.reloadData()
            })
            response.result.error.map({ (error) in
                print(error.localizedDescription)
            })
            self.tableView.backgroundView = self.userList.isEmpty ? self.noDataLabel : nil
        }
    }
    
    func manualRefresh() {
        if let refreshControl = self.tableView.refreshControl {
            tableView.setContentOffset(CGPoint(x: 0, y: -refreshControl.bounds.height), animated: true)
            tableView.refreshControl?.beginRefreshing()
            tableView.refreshControl?.sendActions(for: .valueChanged)
        }
    }

}
