//
//  MoyaProviderUtil.swift
//  Data
//
//  Created by hhhello0507 on 10/4/24.
//

import Moya

enum MoyaProviderUtil {
    static let myAuthSession = Session(interceptor: AuthInterceptor())
    static let mySession = Session()
    static let myPlugins = [
        NetworkLoggerPlugin(
            configuration: .init(
                logOptions: [
                    .requestMethod,
                    .requestBody,
                    .successResponseBody,
                    .errorResponseBody
                ]
            )
        )
    ]
}
