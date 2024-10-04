package com.bestswlkh0310.graduating.graduatingserver.core.user

import jakarta.persistence.*

@Entity(name = "tbl_user")
class User(
    id: Long = 0,
    username: String,
    nickname: String?,
    role: UserRole = UserRole.USER,
    platformType: PlatformType
) {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Long = id
        private set

    @Column(nullable = false)
    var username = username
        private set

    @Column
    var nickname = nickname
        private set

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    var role: UserRole = role
        private set

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    var platformType = platformType
        private set

    fun updateNickname(nickname: String) {
        this.nickname = nickname
    }
}