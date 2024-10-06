package com.bestswlkh0310.graduating.graduatingserver.api.auth.res

import com.bestswlkh0310.graduating.graduatingserver.core.user.UserState
import com.bestswlkh0310.graduating.graduatingserver.infra.token.Token

data class TokenRes(
    val accessToken: String,
    val refreshToken: String,
    val state: UserState
) {
    companion object {
        fun of(token: Token, state: UserState) =
            TokenRes(
                accessToken = token.accessToken,
                refreshToken = token.refreshToken,
                state = state
            )
    }
}