package com.bestswlkh0310.graduating.graduatingserver.api.auth.req

import com.bestswlkh0310.graduating.graduatingserver.core.user.PlatformType

data class SignInReq(
    val platformType: PlatformType,
    val code: String,
)