package com.bestswlkh0310.graduating.graduatingserver.api.user.dto

import jakarta.validation.constraints.Size

data class EditUserReq(
    @Size(min = 1, max = 24)
    val nickname: String,
)