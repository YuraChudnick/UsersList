//
//  NoDataProtocol.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/22/19.
//  Copyright © 2019 yura. All rights reserved.
//

import RxRelay
import RxSwift

protocol NoDataProtocol {
    var isNoData: BehaviorRelay<Bool> { get }
}
