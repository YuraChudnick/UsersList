//
//  Store.swift
//  UserList
//
//  Created by Yurii Chudnovets on 8/23/19.
//  Copyright © 2019 yura. All rights reserved.
//

import Foundation
import RxSwift

class Store<State, Action> {
    
    init(initialState: State, reducer: @escaping (State, Action) -> State) {
        state = actions
            .scan(initialState, accumulator: reducer)
            .startWith(initialState)
            .share(replay: 1)
    }
    
    let state: Observable<State>
    
    private let actions = PublishSubject<Action>()
}

extension Store: ObserverType {
    
    typealias E = Action
    
    func on(_ event: Event<E>) {
        if let element = event.element {
            actions.onNext(element)
        }
    }
}
