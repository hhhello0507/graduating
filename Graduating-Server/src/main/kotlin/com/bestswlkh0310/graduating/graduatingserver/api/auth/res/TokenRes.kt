package com.bestswlkh0310.graduating.graduatingserver.api.auth.res

data class TokenRes(
    val accessToken: String,
    val refreshToken: String
)
