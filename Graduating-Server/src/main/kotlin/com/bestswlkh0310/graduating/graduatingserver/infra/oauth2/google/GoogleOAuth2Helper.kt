package com.bestswlkh0310.graduating.graduatingserver.infra.oauth2.google

import com.bestswlkh0310.graduating.graduatingserver.global.exception.CustomException
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier
import com.google.api.client.http.javanet.NetHttpTransport
import com.google.api.client.json.gson.GsonFactory
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Component

@Component
class GoogleOAuth2Helper(
    private val properties: GoogleOAuth2Properties,
) {

    fun verifyIdToken(idToken: String): GoogleIdToken {
        val verifier = GoogleIdTokenVerifier
            .Builder(NetHttpTransport(), GsonFactory())
            .setAudience(
                listOf(properties.clientId.ios, properties.clientId.web)
            )
            .build()

        return verifier.verify(idToken)
            ?: throw CustomException(HttpStatus.UNAUTHORIZED, "Invalid id token")
    }
}