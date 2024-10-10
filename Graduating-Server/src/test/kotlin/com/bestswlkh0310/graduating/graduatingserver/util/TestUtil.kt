package com.bestswlkh0310.graduating.graduatingserver.util

import com.bestswlkh0310.graduating.graduatingserver.core.user.PlatformType
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserEntity
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserRepository
import com.bestswlkh0310.graduating.graduatingserver.infra.token.JwtClient
import com.bestswlkh0310.graduating.graduatingserver.infra.token.Token

object TestUtil {

    var token: Token? = null
    var user: UserEntity? = null

    fun initializeToken(
        userRepository: UserRepository,
        jwtClient: JwtClient
    ) {
        val user = userRepository.save(
            UserEntity(
                id = 0,
                email = "hhhello0507@gmail.com",
                nickname = "testuser",
                platformType = PlatformType.GOOGLE
            )
        )
        this.user = user
        token = jwtClient.generate(user)
    }
}