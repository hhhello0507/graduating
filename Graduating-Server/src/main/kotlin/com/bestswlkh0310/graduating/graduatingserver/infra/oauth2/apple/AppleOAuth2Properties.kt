package com.bestswlkh0310.graduating.graduatingserver.infra.oauth2.apple

import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.boot.context.properties.bind.ConstructorBinding

@ConfigurationProperties(prefix = "oauth2.apple")
data class AppleOAuth2Properties @ConstructorBinding constructor(
    val grantType: String,
    val bundleId: String,
    val keyId: String,
    val teamId: String,
    val audience: String,
    val privateKey: String,
)