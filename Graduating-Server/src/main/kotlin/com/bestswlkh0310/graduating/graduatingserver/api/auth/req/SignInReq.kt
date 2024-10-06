package com.bestswlkh0310.graduating.graduatingserver.api.auth.req

import com.bestswlkh0310.graduating.graduatingserver.core.user.PlatformType
import jakarta.validation.constraints.Size

data class SignInReq(
    val platformType: PlatformType,
    val code: String,
    @Size(min = 1, max = 24)
    val nickname: String,
    val graduatingYear: Int,
    val schoolId: Long,
)