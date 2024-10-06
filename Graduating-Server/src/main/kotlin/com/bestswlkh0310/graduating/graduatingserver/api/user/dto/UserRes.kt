package com.bestswlkh0310.graduating.graduatingserver.api.user.dto

import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolEntity
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserEntity

data class UserRes(
    val id: Long,
    val email: String,
    val nickname: String,
    val graduatingYear: Int,
    val school: SchoolEntity
) {
    companion object {
        fun of(user: UserEntity) = UserRes(
            id = user.id, 
            email = user.email,
            nickname = user.nickname,
            graduatingYear = user.graduatingYear,
            school = user.school
        )
    }
}