//
//  EditUserProfileVC.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit
import CoreData
import PhoneNumberKit

class EditUserProfileVC: UITableViewController {
    
    lazy var managedObjectContext = CoreDataStack.managedObjectContex
    
    @IBOutlet weak var userAvatar: UIImageView! {
        didSet {
            userAvatar.layer.cornerRadius = userAvatar.bounds.width/2
            userAvatar.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: PhoneNumberTextField!
    
    var user: User?
    var user2: UserEntity?
    
    var isFromSavedVC: Bool = false
    
    lazy var photoPickerManager: PhotoPickerManager = {
        let manager = PhotoPickerManager(presentingViewController: self)
        manager.delegate = self
        return manager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        if user != nil {
            if let picture = user!.picture {
                userAvatar.kf.setImage(with: URL(string: picture.large))
            }
            
            if let name = user!.name {
                firstNameTextField.text = name.first.capitalizingFirstLetter()
                lastNameTextField.text = name.last.capitalizingFirstLetter()
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
    
    @IBAction func saveItem(_ sender: UIBarButtonItem) {
        if !isValidate() { return }
        if !isFromSavedVC, var u = user {
            u.name?.first = firstNameTextField.text!
            u.name?.last = lastNameTextField.text!
            u.email = emailTextField.text!
            u.phone = phoneTextField.text!
            _ = UserEntity.with(user: u, userAvatar.image, in: managedObjectContext)
        } else if isFromSavedVC, let u = user2 {
            u.first_name = firstNameTextField.text!
            u.last_name = lastNameTextField.text!
            u.email = emailTextField.text!
            u.phone = phoneTextField.text!
            if let img = userAvatar.image {
                u.photo = UIImageJPEGRepresentation(img, 1.0)! as NSData
            }
        }
        managedObjectContext.saveChanges()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changePhoto(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default, handler: { [weak self] (action) in
            self?.photoPickerManager.presentPhotoPicker(sourceType: .photoLibrary, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { [weak self] (action) in
            self?.photoPickerManager.presentPhotoPicker(sourceType: .camera, animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    func isValidate() -> Bool {
        if firstNameTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty
            || firstNameTextField.text!.count < 1 || firstNameTextField.text!.count > 30 {
            showAlert(title: "Message", message: "Not saved. First name can containe 1-30 characters, cannot contain only whitespaces.")
            return false
        }
        if lastNameTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty
            || lastNameTextField.text!.count < 1 || lastNameTextField.text!.count > 30 {
            showAlert(title: "Message", message: "Not saved. Last name can containe 1-30 characters, cannot contain only whitespaces.")
            return false
        }
        if !Utils.isValidEmail(emailTextField.text!) {
            showAlert(title: "Message", message: "Wrong email format.")
            return false
        }
        return true
    }
    
}

extension EditUserProfileVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = .black
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.textColor = .darkGray
    }
    
}

extension EditUserProfileVC: PhotoPickerManagerDelegate {
    
    func manager(_ manager: PhotoPickerManager, didPickImage image: UIImage) {
        userAvatar.image = image
        manager.dismissPhotoPicker(animated: true, completion:
            nil)
    }
    
}
