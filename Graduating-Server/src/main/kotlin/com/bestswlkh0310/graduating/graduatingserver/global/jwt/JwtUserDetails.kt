package com.bestswlkh0310.graduating.graduatingserver.global.jwt


import com.bestswlkh0310.graduating.graduatingserver.core.user.UserEntity
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.userdetails.UserDetails

class JwtUserDetails(
    val user: UserEntity
) : UserDetails {
    override fun getAuthorities() = listOf(GrantedAuthority { user.role.name })
    override fun getPassword() = null
    override fun getUsername() = user.email
    override fun isAccountNonExpired() = true // 계정이 만료 되었는지 (true: 만료X)
    override fun isAccountNonLocked() = true // 계정이 잠겼는지 (true: 잠기지 않음)
    override fun isCredentialsNonExpired() = true // 비밀번호가 만료되었는지 (true: 만료X)
    override fun isEnabled() = true
}