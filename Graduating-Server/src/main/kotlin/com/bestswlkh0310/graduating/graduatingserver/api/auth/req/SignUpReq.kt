package com.bestswlkh0310.graduating.graduatingserver.api.auth.req

import jakarta.validation.constraints.Size

data class SignUpReq(
    @Size(min = 1, max = 24)
    val nickname: String,
    val graduatingYear: Int,
    val schoolId: Long,
)