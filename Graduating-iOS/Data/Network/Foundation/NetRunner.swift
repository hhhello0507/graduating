//  Author: hhhello0507
//  Created: 10/5/24


import Foundation
import Combine
import MyMoya
import Moya
import SignKit

let runner = DefaultNetRunner(
    provider: .init(
        session: MoyaProviderUtil.mySession,
        plugins: MoyaProviderUtil.myPlugins
    ),
    authProvider: .init(
        session: MoyaProviderUtil.myAuthSession,
        plugins: MoyaProviderUtil.myPlugins
    )
)

extension NetRunner {
    func deepDive<DTO: Decodable>(
        _ target: MyTarget,
        res: DTO.Type
    ) -> AnyPublisher<DTO, APIError> {
        if target.authorization == .refresh && !Sign.me.isLoggedIn {
            return Empty().eraseToAnyPublisher()
        }
        let ret: AnyPublisher<DTO, MoyaError> = self.deepDive(target, res: DTO.self)
        return ret.mapError { $0.toAPIError(using: .myDecoder) }.eraseToAnyPublisher()
    }
}

private extension Error {
    func toAPIError(using decoder: JSONDecoder) -> APIError {
        guard let error = self as? MoyaError,
              let response = error.response else {
            return APIError.unknown
        }
        if case .underlying(let error, _) = error,
           let error = error.asAFError,
           case .requestRetryFailed(let retryError, _) = error,
           let error = retryError as? APIError {
            return error
        }
        guard let error = try? decoder.decode(ErrorRes.self, from: response.data) else {
            return APIError.unknown
        }
        return APIError.http(error)
    }
}
