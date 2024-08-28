//
//  Result.swift
//  Data
//
//  Created by hhhello0507 on 8/28/24.
//

import Combine
import MyMoya

public typealias Result<T> = AnyPublisher<T, APIError<EmptyErrorResponse>>
