//
//  EditUserProfileVC.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit

class EditUserProfileVC: UITableViewController {
    
    lazy var managedObjectContext = CoreDataStack().managedObjectContex
    
    @IBOutlet weak var userAvatar: UIImageView! {
        didSet {
            userAvatar.layer.cornerRadius = userAvatar.bounds.width/2
            userAvatar.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var user: User?
    var user2: UserEntity?

    override func viewDidLoad() {
        super.viewDidLoad()

        if user != nil {
            if let picture = user!.picture {
                userAvatar.kf.setImage(with: URL(string: picture.large))
            }
            
            if let name = user!.name {
                firstNameTextField.text = name.first
                lastNameTextField.text = name.last
            }
            
            emailTextField.text = user!.email
            phoneTextField.text = user!.phone
            
        } else if user2 != nil {
            
            userAvatar.image = user2!.image
            firstNameTextField.text = user2!.first_name
            lastNameTextField.text = user2!.last_name
            emailTextField.text = user2!.email
            phoneTextField.text = user2!.phone
            
        }
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: .zero)
    }

}
