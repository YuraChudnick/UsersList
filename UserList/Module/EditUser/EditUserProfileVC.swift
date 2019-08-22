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

class EditUserProfileVC: UITableViewController, EditUserProfileViewProtocol {

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
    
    var presenter: EditUserProfilePresenterProtocol!
    
    lazy var photoPickerManager: PhotoPickerManager = {
        let manager = PhotoPickerManager(presentingViewController: self)
        manager.delegate = self
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        presenter.showUserInfo()
    }
    
    fileprivate func setupTableView() {
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    @IBAction func saveItem(_ sender: UIBarButtonItem) {
        if !isValidate() { return }
        presenter.updateFirstName(first: firstNameTextField.text!)
        presenter.updateLastName(last: lastNameTextField.text!)
        presenter.updateEmail(email: emailTextField.text!)
        presenter.updatePhone(phone: phoneTextField.text!)
        if let img = userAvatar.image {
            presenter.updatePhoto(photo: img.jpegData(compressionQuality: 1.0)! as NSData)
        }
        presenter.didPressSaveItem()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changePhoto(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Photo Library", style: UIAlertAction.Style.default, handler: { [weak self] (action) in
            self?.photoPickerManager.presentPhotoPicker(sourceType: .photoLibrary, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { [weak self] (action) in
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
    
    func setUserInfo(info: User?) {
        if let imgName = info?.picture?.large {
            userAvatar.kf.setImage(with: URL(string: imgName))
        }
        firstNameTextField.text = info?.name?.first.capitalizingFirstLetter()
        lastNameTextField.text = info?.name?.last.capitalizingFirstLetter()
        emailTextField.text = info?.email
        phoneTextField.text = info?.phone
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
