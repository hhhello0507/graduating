package com.bestswlkh0310.graduating.graduatingserver.infra.oauth2.google

import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.boot.context.properties.bind.ConstructorBinding

@ConfigurationProperties(prefix = "oauth2.google")
class GoogleOAuth2Properties @ConstructorBinding constructor(
    val clientId: ClientIdProperties,
    val clientSecret: String,
    val redirectUri: String,
    val tokenUri: String,
    val resourceUri: String,
    val grantType: String,
) {
    data class ClientIdProperties(
        val ios: String,
        val web: String,
    )
}