package com.bestswlkh0310.graduating.graduatingserver.api.auth

import com.bestswlkh0310.graduating.graduatingserver.api.auth.req.SignUpReq
import com.bestswlkh0310.graduating.graduatingserver.api.auth.req.RefreshReq
import com.bestswlkh0310.graduating.graduatingserver.api.auth.req.SignInReq
import com.bestswlkh0310.graduating.graduatingserver.api.auth.res.TokenRes
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolRepository
import com.bestswlkh0310.graduating.graduatingserver.core.school.getBy
import com.bestswlkh0310.graduating.graduatingserver.core.user.*
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
    private val schoolRepository: SchoolRepository,
    private val googleOAuth2Client: GoogleOAuth2Client,
    private val appleOAuth2Client: AppleOAuth2Client,
    private val appleOAuth2Helper: AppleOAuth2Helper,
    private val googleOAuth2Helper: GoogleOAuth2Helper,
    private val jwtClient: JwtClient,
    private val sessionHolder: UserAuthenticationHolder
) {
    fun signIn(req: SignInReq): TokenRes {
        val email = when (req.platformType) {
            PlatformType.GOOGLE -> googleSignIn(req.code)
            PlatformType.APPLE -> appleSignIn(req.code)
        }
        val user = userRepository.getByEmail(email)
        
        return TokenRes.of(
            token = jwtClient.generate(user),
            state = user.state
        )
    }

    fun signUp(req: SignUpReq): TokenRes {
        val school = schoolRepository.getBy(req.schoolId)
        val user = sessionHolder.current()
        
        if (user.isActive) {
            throw CustomException(HttpStatus.BAD_REQUEST, "User already sign in")
        }
        
        user.active(
            nickname = req.nickname,
            graduatingYear = req.graduatingYear,
            school = school,
        )
        userRepository.save(user)

        return TokenRes.of(
            token = jwtClient.generate(user),
            state = user.state
        )
    }

    // return email
    private fun googleSignIn(code: String): String {
        val token = googleOAuth2Client.getToken(code = code)
        val idToken = googleOAuth2Helper.verifyIdToken(idToken = token.idToken)
        val email = idToken.payload.email
        return email
    }

    // return email
    private fun appleSignIn(code: String): String {
        val token = appleOAuth2Client.getToken(code = code)
        val headers = appleOAuth2Helper.parseHeader(idToken = token.idToken)
        val keys = appleOAuth2Client.getPublicKeys()
        val publicKey = appleOAuth2Helper.generate(headers = headers, keys = keys)
        val claims = appleOAuth2Helper.extractClaims(idToken = token.idToken, publicKey = publicKey)
        val email = claims["email"] as? String ?: throw CustomException(HttpStatus.BAD_REQUEST, "Invalid email")
        return email
    }

    fun refresh(req: RefreshReq): TokenRes {
        jwtClient.parseToken(req.refreshToken)

        val user = run {
            val email = jwtClient.payload(JwtPayloadKey.EMAIL, req.refreshToken)
            userRepository.getByEmail(email)
        }

        return TokenRes.of(
            token = jwtClient.generate(user),
            state = user.state
        )
    }
}