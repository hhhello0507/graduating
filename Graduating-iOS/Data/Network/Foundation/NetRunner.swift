//  Author: hhhello0507
//  Created: 10/5/24


import Foundation
import MyMoya

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
