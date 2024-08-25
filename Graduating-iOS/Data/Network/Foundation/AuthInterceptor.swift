//import Alamofire
//import UIKit
//import Foundation
//import Domain
//import DIContainer
//import SwiftUI
//import Combine
//import Moya
//import SwiftUtil
//
//final class AuthInterceptor: Moya.RequestInterceptor {
//    
//    @Inject private var keyValueStore: any KeyValueRepo
//    @Inject private var memberRepo: MemberRepo
//    
//    private var subscriptions = Set<AnyCancellable>()
//    
//    init() {}
//    
//    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Swift.Result<URLRequest, Error>) -> Void) {
//        
//        var modifiedRequest = urlRequest
//        guard let accessToken: String = keyValueStore.load(key: .accessToken) else {
//            completion(.success(urlRequest))
//            return
//        }
//        log("✅ AuthInterceptor - Set token: \(accessToken)")
//        modifiedRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
//        completion(.success(modifiedRequest))
//    }
//    
//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//        
//        log("✅ AuthInterceptor - Start refresh")
//        guard request.retryCount <= 3 else {
//            log("❌ AuthInterceptor - RetryCount가 3보다 큽니다")
//            return
//        }
//        
//        guard let url = request.request?.url else {
//            log("❌ AuthInterceptor - Invalid URL")
//            completion(.doNotRetryWithError(error))
//            return
//        }
//        log("✅ AuthInterceptor - URL String: \(url.absoluteString)")
//        
//        guard let response = request.task?.response as? HTTPURLResponse else {
//            log("❌ AuthInterceptor - Invalid Response")
//            completion(.doNotRetryWithError(error))
//            return
//        }
//        log("✅ AuthInterceptor - StatusCode: \(response.statusCode)")
//        
//        let refreshStatusCode = [403, 401]
//        guard refreshStatusCode.contains(response.statusCode) else {
//            log("❌ AuthInterceptor - Invalid StatusCode")
//            completion(.doNotRetryWithError(error))
//            return
//        }
//        
//        let refreshToken = keyValueStore.load(key: .refreshToken) ?? ""
//        guard !refreshToken.isEmpty else {
//            log("❌ AuthInterceptor - Refresh Token is Empty")
//            failureReissue()
//            completion(.doNotRetryWithError(APIError.refreshFailure))
//            return
//        }
//        
//        log("✅ AuthInterceptor - Try refresh with token - \(refreshToken)")
//        
//        memberRepo.refresh(token: refreshToken)
//            .sink { [self] result in
//                switch result {
//                case .success(let res):
//                    log("✅ AuthInterceptor - Refresh Success")
//                    let accessToken = String(res.data.split(separator: " ")[1])
//                    keyValueStore.save(key: .accessToken, value: accessToken)
//                    completion(.retry)
//                case .failure(let error):
//                    log(error)
//                    failureReissue()
//                    log("❌ AuthInterceptor - Refresh Failure")
//                    completion(.doNotRetryWithError(APIError.refreshFailure))
//                case .fetching:
//                    break
//                }
//            }
//            .store(in: &subscriptions)
//    }
//    
//    private func failureReissue() {
//        keyValueStore.delete(key: .accessToken)
//        keyValueStore.delete(key: .refreshToken)
//    }
//    
//    deinit {
//        subscriptions.forEach { $0.cancel() }
//    }
//}
