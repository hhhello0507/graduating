package com.bestswlkh0310.graduating.graduatingserver.core.meal

enum class MealType {
    BREAKFAST,
    LAUNCH,
    DINNER;

    companion object {
        fun ofKorean(string: String) = entries.firstOrNull { it.korean() == string }
    }

    fun korean() = when (this) {
        BREAKFAST -> "조식"
        LAUNCH -> "중식"
        DINNER -> "석식"
    }
}