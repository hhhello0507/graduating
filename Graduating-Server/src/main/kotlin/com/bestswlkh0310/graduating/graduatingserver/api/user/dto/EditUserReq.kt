package com.bestswlkh0310.graduating.graduatingserver.api.user.dto

import jakarta.validation.constraints.NotBlank

data class EditUserReq(
    @field:NotBlank
    val nickname: String,
)