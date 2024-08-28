package com.bestswlkh0310.graduating.graduatingserver.common

fun String.kcal() = this.substringBefore(" Kcal").toDoubleOrNull()