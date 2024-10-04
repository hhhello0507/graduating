package com.bestswlkh0310.graduating.graduatingserver

import com.bestswlkh0310.graduating.graduatingserver.api.auth.res.TokenRes
import com.bestswlkh0310.graduating.graduatingserver.core.user.PlatformType
import com.bestswlkh0310.graduating.graduatingserver.core.user.User
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserRepository
import com.bestswlkh0310.graduating.graduatingserver.infra.token.JwtClient
import com.bestswlkh0310.graduating.graduatingserver.util.TestAnnotation
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.test.web.servlet.MockMvc

@TestAnnotation
class AuthControllerTest {

    @Autowired
    lateinit var userRepository: UserRepository
    @Autowired
    lateinit var jwtClient: JwtClient
    @Autowired
    lateinit var mvc: MockMvc

    private var token: TokenRes? = null

    @BeforeEach
    fun beforeEach() {
        val user = userRepository.save(
            User(
                id = 0,
                username = "hhhello0507@gmail.com",
                nickname = "testuser",
                platformType = PlatformType.GOOGLE
            )
        )
        token = jwtClient.generate(user)
    }

    @Test
    fun `sign up`() {
//        mvc.perform(
//            MockMvcRequestBuilders.post("/api/auth/signup")
//        )
        println(token)
    }
}
