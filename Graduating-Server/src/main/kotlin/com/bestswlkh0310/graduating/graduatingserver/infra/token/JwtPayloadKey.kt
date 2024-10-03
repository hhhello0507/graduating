package com.bestswlkh0310.graduating.graduatingserver.infra.token

enum class JwtPayloadKey(
    val key: String
) {
    ID("id"),
    USERNAME("username"),
    ROLE("role");
}