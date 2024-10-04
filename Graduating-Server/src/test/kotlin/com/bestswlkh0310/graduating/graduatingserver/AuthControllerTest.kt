package com.bestswlkh0310.graduating.graduatingserver

import com.bestswlkh0310.graduating.graduatingserver.api.auth.res.TokenRes
import com.bestswlkh0310.graduating.graduatingserver.core.user.PlatformType
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserEntity
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserRepository
import com.bestswlkh0310.graduating.graduatingserver.infra.token.JwtClient
import org.junit.jupiter.api.BeforeAll
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.test.web.servlet.MockMvc

@TestAnnotation
class AuthControllerTest {

    @Autowired
    lateinit var mvc: MockMvc
    
    companion object {
        private var token: TokenRes? = null

        @BeforeAll
        @JvmStatic
        fun beforeAll(
            @Autowired userRepository: UserRepository,
            @Autowired jwtClient: JwtClient
        ) {
            val user = userRepository.save(
                UserEntity(
                    id = 0,
                    username = "hhhello0507@gmail.com",
                    nickname = "testuser",
                    platformType = PlatformType.GOOGLE
                )
            )
            token = jwtClient.generate(user)
        }
    }

    @Test
    fun `sign up`() {
//        mvc.perform(
//            MockMvcRequestBuilders.post("/api/auth/signup")
//        )
        println(token)
    }
}
