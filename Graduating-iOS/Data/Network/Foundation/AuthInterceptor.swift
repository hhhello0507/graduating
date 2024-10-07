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
            DispatchQueue.main.async {
                completion(.doNotRetryWithError(error))
            }
            return
        }
        
        guard request.retryCount <= 2 else {
            print("❌ AuthInterceptor - RetryCount가 2보다 큽니다")
            DispatchQueue.main.async {
                completion(.doNotRetryWithError(APIError.refreshFailure))
            }
            return
        }
        
        print("❌ AuthInterceptor - statusCode: \(response.statusCode)")
        
        let tokenExpiredStatusCode = 403
        guard response.statusCode == tokenExpiredStatusCode else {
            print("❌ AuthInterceptor - HTTP statusCode is not \(tokenExpiredStatusCode)")
            DispatchQueue.main.async {
                completion(.doNotRetryWithError(error))
            }
            return
        }
        guard let refreshToken = Sign.me.refreshToken else {
            print("❌ AuthInterceptor - refreshToken is nil")
            DispatchQueue.main.async {
                completion(.doNotRetryWithError(APIError.refreshFailure))
            }
            return
        }
        
        AuthService.shared.refresh(
            .init(refreshToken: refreshToken)
        ).sink {
            if case .failure = $0 {
                DispatchQueue.main.async {
                    completion(.doNotRetryWithError(APIError.refreshFailure))
                }
            }
        } receiveValue: { token in
            DispatchQueue.main.async {
                Sign.me.reissue(token.accessToken)
                completion(.retry)
            }
        }.store(in: &subscription)
    }
}
