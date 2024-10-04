package com.bestswlkh0310.graduating.graduatingserver.api

import com.bestswlkh0310.graduating.graduatingserver.TestAnnotation
import com.bestswlkh0310.graduating.graduatingserver.api.user.dto.EditUserReq
import com.bestswlkh0310.graduating.graduatingserver.api.user.dto.UserRes
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserRepository
import com.bestswlkh0310.graduating.graduatingserver.infra.token.JwtClient
import com.bestswlkh0310.graduating.graduatingserver.util.TestUtil
import com.bestswlkh0310.graduating.graduatingserver.util.fromJson
import com.bestswlkh0310.graduating.graduatingserver.util.toJson
import org.junit.jupiter.api.BeforeAll
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.fail
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.MediaType
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders
import org.springframework.test.web.servlet.result.MockMvcResultMatchers
import java.net.http.HttpHeaders
import java.util.*
import kotlin.test.assertEquals
import kotlin.test.assertNotEquals

@TestAnnotation
class UserControllerTest {

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
    fun `get me test`() {
        val token = TestUtil.token ?: fail("token is null")
        val user = TestUtil.user ?: fail("user is null")
        
        val res = mvc.perform(
            MockMvcRequestBuilders.get("/user/me")
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer ${token.accessToken}")
        ).andExpect(MockMvcResultMatchers.status().isOk)
            .andReturn().response.contentAsString
            .fromJson<UserRes>()
        
        assertEquals(user.username, res.username)
        assertEquals(user.nickname, res.nickname)
    }
    
    @Test
    fun `edit user and get me test`() {
        val token = TestUtil.token ?: fail("token is null")
        val user = TestUtil.user ?: fail("user is null")
        
        val editNickname = UUID.randomUUID().toString()
        
        // edit user
        mvc.perform(
            MockMvcRequestBuilders.patch("/user")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                    EditUserReq(
                        nickname = editNickname
                    ).toJson()
                )
                .header("Authorization", "Bearer ${token.accessToken}")
        ).andExpect(MockMvcResultMatchers.status().isOk)
        
        // get me
        val res = mvc.perform(
            MockMvcRequestBuilders.get("/user/me")
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer ${token.accessToken}")
        ).andExpect(MockMvcResultMatchers.status().isOk)
            .andReturn().response.contentAsString
            .fromJson<UserRes>()

        assertEquals(user.username, res.username)
        assertEquals(editNickname, res.nickname)
        assertNotEquals(user.nickname, res.nickname)
    }
}