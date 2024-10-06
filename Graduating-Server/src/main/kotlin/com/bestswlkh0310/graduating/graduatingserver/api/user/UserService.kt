package com.bestswlkh0310.graduating.graduatingserver.api.user

import com.bestswlkh0310.graduating.graduatingserver.api.core.VoidRes
import com.bestswlkh0310.graduating.graduatingserver.api.user.dto.EditUserReq
import com.bestswlkh0310.graduating.graduatingserver.api.user.dto.UserRes
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserAuthenticationHolder
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserRepository
import org.springframework.stereotype.Service

@Service
class UserService(
    private val userRepository: UserRepository,
    private val userAuthenticationHolder: UserAuthenticationHolder
) {
    fun getMe(): UserRes = UserRes.of(
        userAuthenticationHolder.current()
    )

    fun editUser(req: EditUserReq): VoidRes {
        val user = userAuthenticationHolder.current()
        user.update(req.nickname)
        userRepository.save(user)
        return VoidRes()
    }
}