package com.bestswlkh0310.graduating.graduatingserver.global.config

import com.bestswlkh0310.graduating.graduatingserver.core.user.UserRepository
import com.bestswlkh0310.graduating.graduatingserver.core.user.getByUsername
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.stereotype.Service

@Service
class JwtUserDetailsService(
    private val userRepository: UserRepository,
) : UserDetailsService {
    override fun loadUserByUsername(username: String) =
        JwtUserDetails(userRepository.getByUsername(username))
}