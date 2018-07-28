//
//  PhotoPickerManager.swift
//  UserList
//
//  Created by yura on 28.07.2018.
//  Copyright © 2018 yura. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol PhotoPickerManagerDelegate: class {
    func manager(_ manager: PhotoPickerManager, didPickImage image: UIImage)
}

class PhotoPickerManager: NSObject {
    private let imagePickerController = UIImagePickerController()
    private let presentingController: UIViewController
    weak var delegate: PhotoPickerManagerDelegate?
    
    init(presentingViewController: UIViewController) {
        self.presentingController = presentingViewController
        super.init()
        
        configure()
    }
    
    func presentPhotoPicker(sourceType: UIImagePickerControllerSourceType, animated: Bool) {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) && sourceType == .camera { return }
        imagePickerController.sourceType = sourceType
        presentingController.present(imagePickerController, animated: animated, completion: nil)
    }
    
    func dismissPhotoPicker(animated: Bool, completion: (() -> Void)?) {
        imagePickerController.dismiss(animated: animated, completion: completion)
    }
    
    private func configure() {
        
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        
        imagePickerController.delegate = self
    }
}

extension PhotoPickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        delegate?.manager(self, didPickImage: image)
    }
}

