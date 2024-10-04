//
//  RemoteInterceptor.swift
//  DodamDodam
//
//  Created by Mercen on 3/31/24.
//

import Foundation
import Combine

import Alamofire
import SignKit

class AuthInterceptor: RequestInterceptor {
    
    var subscription = Set<AnyCancellable>()
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        guard let accessToken = Sign.me.accessToken else {
            completion(.success(urlRequest))
            return
        }
        print("✅ AuthInterceptor - Set token \(accessToken)")
        var modifiedRequest = urlRequest
        modifiedRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(modifiedRequest))
    }

    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        guard request.retryCount <= 2 else {
            print("❌ AuthInterceptor - RetryCount가 2보다 큽니다")
            return
        }
        
        if response.statusCode == 200 {
            completion(.doNotRetry)
            return
        }
        
        print("❌ AuthInterceptor - statusCode: \(response.statusCode)")
        
        let tokenExpiredStatusCode = 403
        guard response.statusCode == tokenExpiredStatusCode, let refreshToken = Sign.me.refreshToken else {
            print("❌ AuthInterceptor - refreshToken is nil")
            completion(.doNotRetryWithError(error))
            return
        }
        
        AuthService.shared.refresh(
            .init(refreshToken: refreshToken)
        ).sink {
            if case .failure(let error) = $0 {
                completion(.doNotRetryWithError(error))
            }
        } receiveValue: { token in
            Sign.me.reissue(token.accessToken)
            completion(.retry)
        }.store(in: &subscription)
    }
}
