package com.bestswlkh0310.graduating.graduatingserver.api.user.dto

import com.bestswlkh0310.graduating.graduatingserver.core.user.UserEntity

data class UserRes(
    val username: String,
    val nickname: String?,
) {
    companion object {
        fun of(user: UserEntity) = UserRes(
            username = user.username,
            nickname = user.nickname,
        )
    }
}
