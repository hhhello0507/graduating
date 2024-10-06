package com.bestswlkh0310.graduating.graduatingserver.api.auth.req

import com.bestswlkh0310.graduating.graduatingserver.core.user.PlatformType
import jakarta.validation.constraints.Size

data class SignUpReq(
    val platformType: PlatformType,
    val code: String,
)