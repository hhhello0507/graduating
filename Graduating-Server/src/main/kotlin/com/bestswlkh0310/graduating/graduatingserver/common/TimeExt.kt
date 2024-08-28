package com.bestswlkh0310.graduating.graduatingserver.common

import java.time.LocalDate
import java.time.LocalDateTime
import java.time.LocalTime
import java.time.format.DateTimeFormatter
import java.time.format.DateTimeParseException

fun LocalDateTime.parse(format: String) = this.format(DateTimeFormatter.ofPattern(format))
fun LocalDate.parse(format: String) = this.format(DateTimeFormatter.ofPattern(format))
fun LocalTime.parse(format: String) = DateTimeFormatter.ofPattern(format)

fun String.toTime(pattern: String = "yyyyMMdd") = try {
    val formatter = DateTimeFormatter.ofPattern(pattern)
    val localDate = LocalDate.parse(this, formatter)
    localDate.atStartOfDay()
} catch (e: DateTimeParseException) {
    null
}