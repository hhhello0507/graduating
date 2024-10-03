package com.bestswlkh0310.graduating.graduatingserver.core.school

enum class SchoolType {
    HIGH,
    MIDDLE,
    ELEMENTARY;

    companion object {
        fun ofKorean(string: String) = entries.firstOrNull { it.korean() == string }
    }

    fun korean() = when(this) {
        HIGH -> "고등학교"
        MIDDLE -> "중학교"
        ELEMENTARY -> "초등학교"
    }
}