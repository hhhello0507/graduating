package com.bestswlkh0310.graduating.graduatingserver.core.user

import jakarta.persistence.*

@Entity(name = "`user`")
class User(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) 
    val id: Long = 0,

    @Column(nullable = false)
    val username: String,
    
    @Column(nullable = false)
    val nickname: String?,

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    val role: UserRole = UserRole.USER,

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    val platformType: PlatformType = PlatformType.DEFAULT
)