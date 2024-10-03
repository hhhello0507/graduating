package com.bestswlkh0310.graduating.graduatingserver.infra.token

import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.boot.context.properties.bind.ConstructorBinding

@ConfigurationProperties(prefix = "jwt")
data class JwtProperties @ConstructorBinding constructor(
    val expired: ExpiredProperties,
    val secretKey: String,
) {
    data class ExpiredProperties(
        val access: Long,
        val refresh: Long
    )
}