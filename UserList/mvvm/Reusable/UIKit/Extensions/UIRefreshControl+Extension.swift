//
//  UIRefreshControl+Extension.swift
//  UserList
//
//  Created by yura on 8/25/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit

extension UIRefreshControl {
    
    func beginRefreshingWithAnimation(withAction: Bool = true) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            if let tableView = self.superview as? UITableView {
                let tbHeaderHeight = tableView.tableHeaderView?.bounds.height ?? 0
                print(CGPoint(x: 0, y: -(self.frame.height + tbHeaderHeight)))
                tableView.setContentOffset(CGPoint(x: 0, y: -(self.frame.height + tbHeaderHeight)), animated: true)
            }
            self.beginRefreshing()
            if withAction { self.sendActions(for: .valueChanged) }
        }
    }
}
