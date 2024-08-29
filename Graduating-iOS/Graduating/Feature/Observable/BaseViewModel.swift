//
//  BaseViewModel.swift
//  Graduating
//
//  Created by hhhello0507 on 8/29/24.
//

import Combine

open class BaseViewModel: ObservableObject {
    public var subscriptions = Set<AnyCancellable>()
    
    deinit {
        subscriptions.forEach {
            $0.cancel()
        }
    }
}
