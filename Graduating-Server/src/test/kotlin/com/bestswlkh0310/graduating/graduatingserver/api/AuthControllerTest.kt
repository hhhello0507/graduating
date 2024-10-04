package com.bestswlkh0310.graduating.graduatingserver.api

import com.bestswlkh0310.graduating.graduatingserver.TestAnnotation
import com.bestswlkh0310.graduating.graduatingserver.api.auth.req.RefreshReq
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserRepository
import com.bestswlkh0310.graduating.graduatingserver.infra.token.JwtClient
import com.bestswlkh0310.graduating.graduatingserver.util.TestUtil
import com.bestswlkh0310.graduating.graduatingserver.util.toJson
import org.junit.jupiter.api.BeforeAll
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.MediaType
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders
import org.springframework.test.web.servlet.result.MockMvcResultMatchers
import kotlin.test.junit5.JUnit5Asserter.fail

@TestAnnotation
class AuthControllerTest {

    @Autowired
    lateinit var mvc: MockMvc

    companion object {

        @BeforeAll
        @JvmStatic
        fun beforeAll(
            @Autowired userRepository: UserRepository,
            @Autowired jwtClient: JwtClient
        ) {
            TestUtil.initializeToken(userRepository, jwtClient)
        }
    }

    @Test
    fun `refresh test`(
        @Autowired userRepository: UserRepository,
    ) {
        val token = TestUtil.token ?: fail("token is null")
        mvc.perform(
            MockMvcRequestBuilders.post("/auth/refresh")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                    RefreshReq(
                        refreshToken = token.refreshToken
                    ).toJson()
                )
        ).andExpect(MockMvcResultMatchers.status().isOk)
    }
}
