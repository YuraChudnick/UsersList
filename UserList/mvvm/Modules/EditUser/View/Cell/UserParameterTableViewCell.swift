//
//  UserParameterTableViewCell.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/16/19.
//  Copyright © 2019 yura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserParameterTableViewCell: NiblessTableViewCell {
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.textAlignment = .left
        l.textColor = .black
        return l
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        tf.textColor = .darkGray
        tf.textAlignment = .right
        return tf
    }()
    
    var viewModel: UserParameterViewModelProtocol? {
        didSet {
            disposeBag = DisposeBag()
            titleLabel.text = viewModel?.type.rawValue
            //textField.text = viewModel.value.value //set manually
            
            //two way data binding
            viewModel?.value
                .asObservable()
                .bind(to: textField.rx.text)
                .disposed(by: disposeBag)
            
            textField.rx.text
                .orEmpty
                .bind(to: viewModel!.value)
                .disposed(by: disposeBag)
        }
    }
    
    var disposeBag: DisposeBag!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = nil
    }
    
    fileprivate func setupViews() {
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: contentView.topAnchor,
                          leading: contentView.leadingAnchor,
                          bottom: contentView.bottomAnchor,
                          trailing: nil,
                          padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0),
                          size: CGSize(width: 0, height: 50))
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        
        contentView.addSubview(textField)
        textField.anchor(top: nil,
                         leading: titleLabel.trailingAnchor,
                         bottom: nil,
                         trailing: contentView.trailingAnchor,
                         centerY: contentView.centerYAnchor,
                         padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 16))
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .horizontal)
        textField.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 250), for: .horizontal)
        
    }
    
}
