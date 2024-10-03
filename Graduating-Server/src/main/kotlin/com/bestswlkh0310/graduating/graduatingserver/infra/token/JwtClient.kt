package com.bestswlkh0310.graduating.graduatingserver.infra.token

import com.bestswlkh0310.graduating.graduatingserver.api.auth.res.TokenRes
import com.bestswlkh0310.graduating.graduatingserver.core.user.User
import com.bestswlkh0310.graduating.graduatingserver.global.exception.CustomException
import io.jsonwebtoken.*
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Component
import java.nio.charset.StandardCharsets
import java.security.SignatureException
import java.util.*
import javax.crypto.spec.SecretKeySpec

@Component
class JwtClient(
    private val jwtProperties: JwtProperties,
) {
    fun payload(key: JwtPayloadKey, token: String): String =
        parseToken(token).payload.get(key.key, String::class.java)

    fun parseToken(token: String): Jws<Claims> =
        try {
            parser().parseSignedClaims(token)
        } catch (e: ExpiredJwtException) {
            throw CustomException(HttpStatus.FORBIDDEN, "expired jwt")
        } catch (e: SignatureException) {
            throw CustomException(HttpStatus.UNAUTHORIZED, "invalid signature")
        } catch (e: MalformedJwtException) {
            throw CustomException(HttpStatus.UNAUTHORIZED, "malformed jwt")
        } catch (e: UnsupportedJwtException) {
            throw CustomException(HttpStatus.UNAUTHORIZED, "unsupported jwt")
        } catch (e: IllegalArgumentException) {
            throw CustomException(HttpStatus.UNAUTHORIZED, "illegal argument error (jwt)")
        } catch (e: Exception) {
            throw CustomException(HttpStatus.UNAUTHORIZED, "invalid token")
        }

    fun generate(user: User) = TokenRes(
        accessToken = createToken(
            user = user,
            tokenExpired = jwtProperties.accessExpired,
        ),
        refreshToken = createToken(
            user = user,
            tokenExpired = jwtProperties.refreshExpired,
        )
    )

    private fun secretKey() = SecretKeySpec(
        jwtProperties.secretKey.toByteArray(StandardCharsets.UTF_8),
        Jwts.SIG.HS256.key().build().algorithm
    )

    private fun parser() =
        Jwts.parser().verifyWith(secretKey()).build()

    private fun createToken(user: User, tokenExpired: Long) =
        Jwts.builder()
            .claim(JwtPayloadKey.ID.key, user.id)
            .claim(JwtPayloadKey.USERNAME.key, user.username)
            .claim(JwtPayloadKey.ROLE.key, user.role)
            .issuedAt(Date())
            .expiration(Date(Date().time + tokenExpired))
            .signWith(secretKey())
            .compact()
}