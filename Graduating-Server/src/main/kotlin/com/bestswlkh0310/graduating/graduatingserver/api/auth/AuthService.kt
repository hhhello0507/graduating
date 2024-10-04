package com.bestswlkh0310.graduating.graduatingserver.api.auth

import com.bestswlkh0310.graduating.graduatingserver.api.auth.req.OAuth2SignInReq
import com.bestswlkh0310.graduating.graduatingserver.api.auth.req.RefreshReq
import com.bestswlkh0310.graduating.graduatingserver.api.auth.res.TokenRes
import com.bestswlkh0310.graduating.graduatingserver.core.user.PlatformType
import com.bestswlkh0310.graduating.graduatingserver.core.user.User
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserRepository
import com.bestswlkh0310.graduating.graduatingserver.core.user.getByUsername
import com.bestswlkh0310.graduating.graduatingserver.global.exception.CustomException
import com.bestswlkh0310.graduating.graduatingserver.infra.oauth2.apple.AppleOAuth2Client
import com.bestswlkh0310.graduating.graduatingserver.infra.oauth2.apple.AppleOAuth2Helper
import com.bestswlkh0310.graduating.graduatingserver.infra.oauth2.google.GoogleOAuth2Client
import com.bestswlkh0310.graduating.graduatingserver.infra.oauth2.google.GoogleOAuth2Helper
import com.bestswlkh0310.graduating.graduatingserver.infra.token.JwtClient
import com.bestswlkh0310.graduating.graduatingserver.infra.token.JwtPayloadKey
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service


@Service
class AuthService(
    private val userRepository: UserRepository,
    private val googleOAuth2Client: GoogleOAuth2Client,
    private val appleOAuth2Client: AppleOAuth2Client,
    private val appleOAuth2Helper: AppleOAuth2Helper,
    private val jwtClient: JwtClient,
    private val googleOAuth2Helper: GoogleOAuth2Helper
) {

    fun refresh(req: RefreshReq): TokenRes {
        jwtClient.parseToken(req.refreshToken)

        val user = run {
            val username = jwtClient.payload(JwtPayloadKey.USERNAME, req.refreshToken)
            userRepository.getByUsername(username)
        }

        return jwtClient.generate(user)
    }

    fun oAuth2SignIn(req: OAuth2SignInReq): TokenRes {
        val user = when (req.platformType) {
            PlatformType.GOOGLE -> googleSignIn(req)
            PlatformType.APPLE -> appleSignIn(req)
            else -> throw CustomException(HttpStatus.BAD_REQUEST, "Invalid platform type")
        }
        
        return jwtClient.generate(user)
    }

    private fun googleSignIn(req: OAuth2SignInReq): User {
        val token = googleOAuth2Client.getToken(code = req.code)
        val idToken = googleOAuth2Helper.verifyIdToken(idToken = token.idToken)
        
        val username = idToken.payload.email
        val users = userRepository.findByUsername(username)
        val user = users.firstOrNull() ?: userRepository.save(
            User(
                username = username,
                nickname = idToken.payload["name"] as? String ?: "유저",
                platformType = req.platformType
            )
        )
        
        return user
    }

    private fun appleSignIn(req: OAuth2SignInReq): User {
        val token = appleOAuth2Client.getToken(code = req.code)
        val headers = appleOAuth2Helper.parseHeader(idToken = token.idToken)
        val keys = appleOAuth2Client.getPublicKeys()
        val publicKey = appleOAuth2Helper.generate(headers = headers, keys = keys)
        val claims = appleOAuth2Helper.extractClaims(idToken = token.idToken, publicKey = publicKey)
        val username = claims["email"] as? String ?: throw CustomException(HttpStatus.BAD_REQUEST, "Invalid email")
        val users = userRepository.findByUsername(username)
        val user = users.firstOrNull() ?: userRepository.save(
            User(
                username = username,
                nickname = null,
                platformType = req.platformType
            )
        )
        return user
    }
}