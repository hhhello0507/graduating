package com.bestswlkh0310.graduating.graduatingserver.entity

enum class SchoolType {
    HIGH,
    MIDDLE,
    ELEMENTARY;

    companion object {
        fun of(string: String) = entries.first {
            it.name == string
        }

        fun ofKorean(string: String) = entries.first {
            it.korean() == string
        }
    }

    fun korean() = when(this) {
        HIGH -> "고등학교"
        MIDDLE -> "중학교"
        ELEMENTARY -> "초등학교"
    }
}