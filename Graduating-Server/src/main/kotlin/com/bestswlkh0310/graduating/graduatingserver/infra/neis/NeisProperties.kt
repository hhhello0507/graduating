package com.bestswlkh0310.graduating.graduatingserver.infra.neis

import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.boot.context.properties.bind.ConstructorBinding

@ConfigurationProperties(prefix = "neis")
class NeisProperties @ConstructorBinding constructor(
    val apiKey: String,
)