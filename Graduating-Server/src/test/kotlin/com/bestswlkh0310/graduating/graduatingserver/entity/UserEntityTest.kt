package com.bestswlkh0310.graduating.graduatingserver.entity

import com.bestswlkh0310.graduating.graduatingserver.core.user.PlatformType
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserEntity
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserRole
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserState
import org.junit.jupiter.api.Test
import java.time.LocalDate
import kotlin.test.assertEquals
import kotlin.test.assertNull

class UserEntityTest {
    companion object {
        val email = "test@example.com"
        val platformType = PlatformType.GOOGLE
        val user = UserEntity(
            email = email,
            platformType = platformType,
        )
        val nickname = "testNickname"
        val veryDistantFuture = 1234567891
        val veryDistantPast = 1
    }
    
    @Test
    fun `create user entity`() {
        assertEquals(email, user.email)
        assertEquals(UserRole.USER, user.role)
        assertEquals(platformType, user.platformType)
        assertEquals(UserState.PENDING, user.state)
        assertNull(user.nickname)
        assertNull(user.graduatingYear)
        assertNull(user.school)
    }
    
    @Test
    fun `active user entity`() {
        user.active(
            nickname = nickname,
            graduatingYear = veryDistantFuture,
            school = SchoolEntityTest.highSchool
        )
        assertEquals(email, user.email)
        assertEquals(nickname, user.nickname)
        // 년도에 따라 테스크 코드가 달리지는 경우 어떻게 해야 하지
        assertEquals(2027, user.graduatingYear)
    }
}