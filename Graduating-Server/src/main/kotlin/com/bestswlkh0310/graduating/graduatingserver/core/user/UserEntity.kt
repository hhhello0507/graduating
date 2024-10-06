package com.bestswlkh0310.graduating.graduatingserver.core.user

import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolEntity
import jakarta.persistence.*

@Entity
@Table(name = "tbl_user")
class UserEntity(
    id: Long = 0,
    email: String,
    nickname: String,
    role: UserRole = UserRole.USER,
    platformType: PlatformType,
    graduatingYear: Int,
    school: SchoolEntity
) {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id = id
        private set

    @Column(nullable = false)
    var email = email
        private set

    @Column(nullable = false)
    var nickname = nickname
        private set

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    var role = role
        private set

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    var platformType = platformType
        private set
    
    @Column(nullable = false)
    var graduatingYear = graduatingYear
        private set
    
    @JoinColumn(name = "school_id", nullable = false)
    @ManyToOne
    var school = school
        private set

    fun updateNickname(nickname: String) {
        this.nickname = nickname
    }
}