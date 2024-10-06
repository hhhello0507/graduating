package com.bestswlkh0310.graduating.graduatingserver.core.user

import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolEntity
import com.bestswlkh0310.graduating.graduatingserver.global.exception.CustomException
import jakarta.persistence.*
import org.springframework.http.HttpStatus

@Entity
@Table(name = "tbl_user")
class UserEntity(
    id: Long = 0,
    email: String,
    role: UserRole = UserRole.USER,
    platformType: PlatformType,
    state: UserState = UserState.PENDING,
    nickname: String? = null,
    graduatingYear: Int? = null,
    school: SchoolEntity? = null,
) {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id = id
        private set

    @Column(nullable = false)
    var email = email
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
    @Enumerated(EnumType.STRING)
    var state = state
        private set

    var nickname = nickname
        private set

    var graduatingYear = graduatingYear
        private set

    @JoinColumn(name = "school_id")
    @ManyToOne
    var school = school
        private set

    val isActive: Boolean
        get() = state == UserState.NONE

    fun active(nickname: String, graduatingYear: Int, school: SchoolEntity) {
        this.state = UserState.NONE
        this.nickname = nickname
        this.graduatingYear = graduatingYear
        this.school = school
    }

    fun update(nickname: String) {
        this.nickname = nickname
    }
}