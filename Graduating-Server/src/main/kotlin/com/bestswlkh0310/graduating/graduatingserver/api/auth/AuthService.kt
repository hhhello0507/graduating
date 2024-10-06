package com.bestswlkh0310.graduating.graduatingserver.api.auth

import com.bestswlkh0310.graduating.graduatingserver.api.auth.req.SignInReq
import com.bestswlkh0310.graduating.graduatingserver.api.auth.req.RefreshReq
import com.bestswlkh0310.graduating.graduatingserver.api.auth.res.TokenRes
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolRepository
import com.bestswlkh0310.graduating.graduatingserver.core.school.getBy
import com.bestswlkh0310.graduating.graduatingserver.core.user.PlatformType
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserEntity
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserRepository
import com.bestswlkh0310.graduating.graduatingserver.core.user.getByUsername
import com.bestswlkh0310.graduating.graduatingserver.global.exception.CustomException
import com.bestswlkh0310.graduating.graduatingserver.infra.oauth2.apple.AppleOAuth2Client
import com.bestswlkh0310.graduating.graduatingserver.infra.oauth2.apple.AppleOAuth2Helper
import com.bestswlkh0310.graduating.graduatingserver.infra.oauth2.google.GoogleOAuth2Client
import com.bestswlkh0310.graduating.graduatingserver.infra.oauth2.google.GoogleOAuth2Helper
import com.bestswlkh0310.graduating.graduatingserver.infra.token.JwtClient
import com.bestswlkh0310.graduating.graduatingserver.infra.token.JwtPayloadKey
import org.springframework.data.repository.findByIdOrNull
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
) {
    fun signIn(req: SignInReq): TokenRes {
        val school = schoolRepository.getBy(req.schoolId)
        val username = when (req.platformType) {
            PlatformType.GOOGLE -> googleSignIn(req)
            PlatformType.APPLE -> appleSignIn(req)
        }

        val user = userRepository.findByUsername(username).firstOrNull()
            ?: userRepository.save(
                UserEntity(
                    username = username,
                    nickname = req.nickname,
                    platformType = req.platformType,
                    graduatingYear = req.graduatingYear,
                    school = school
                )
            )

        return jwtClient.generate(user)
    }

    // return username
    private fun googleSignIn(req: SignInReq): String {
        val token = googleOAuth2Client.getToken(code = req.code)
        val idToken = googleOAuth2Helper.verifyIdToken(idToken = token.idToken)
        val username = idToken.payload.email
        return username
    }

    // return username
    private fun appleSignIn(req: SignInReq): String {
        val token = appleOAuth2Client.getToken(code = req.code)
        val headers = appleOAuth2Helper.parseHeader(idToken = token.idToken)
        val keys = appleOAuth2Client.getPublicKeys()
        val publicKey = appleOAuth2Helper.generate(headers = headers, keys = keys)
        val claims = appleOAuth2Helper.extractClaims(idToken = token.idToken, publicKey = publicKey)
        val username = claims["email"] as? String ?: throw CustomException(HttpStatus.BAD_REQUEST, "Invalid email")
        return username
    }

    fun refresh(req: RefreshReq): TokenRes {
        jwtClient.parseToken(req.refreshToken)

        val user = run {
            val username = jwtClient.payload(JwtPayloadKey.USERNAME, req.refreshToken)
            userRepository.getByUsername(username)
        }

        return jwtClient.generate(user)
    }
}