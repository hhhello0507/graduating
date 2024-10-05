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
