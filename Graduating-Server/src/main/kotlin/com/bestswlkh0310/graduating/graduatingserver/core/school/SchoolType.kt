package com.bestswlkh0310.graduating.graduatingserver.core.school

enum class SchoolType(
    val limit: Int
) {
    HIGH(limit = 3),
    MIDDLE(limit = 3),
    ELEMENTARY(limit = 6);

    companion object {
        fun ofKorean(string: String) = entries.firstOrNull { it.korean() == string }
    }

    fun korean() = when(this) {
        HIGH -> "고등학교"
        MIDDLE -> "중학교"
        ELEMENTARY -> "초등학교"
    }
}