package com.bestswlkh0310.graduating.graduatingserver.infra.publicdata

import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.boot.context.properties.bind.ConstructorBinding

@ConfigurationProperties(prefix = "public-data")
class PublicDataProperties @ConstructorBinding constructor(
    // 한국 장학 재단
    val kosafServiceKey: String
)