package com.bestswlkh0310.graduating.graduatingserver.common

import java.time.LocalDate
import java.time.LocalDateTime
import java.time.LocalTime
import java.time.format.DateTimeFormatter
import java.time.format.DateTimeParseException

fun LocalDateTime.parse(format: String): String = this.format(DateTimeFormatter.ofPattern(format))
fun LocalDate.parse(format: String): String = this.format(DateTimeFormatter.ofPattern(format))
fun LocalTime.parse(format: String): String = this.format(DateTimeFormatter.ofPattern(format))

fun String.toLocalDate(pattern: String) =
    try {
        val formatter = DateTimeFormatter.ofPattern(pattern)
        LocalDate.parse(this, formatter)
    } catch (e: DateTimeParseException) {
        null
    }

fun String.toLocalTime(pattern: String) =
    try {
        val formatter = DateTimeFormatter.ofPattern(pattern)
        LocalTime.parse(this, formatter)
    } catch (e: DateTimeParseException) {
        null
    }

fun String.toLocalDateTime(pattern: String) =
    try {
        val formatter = DateTimeFormatter.ofPattern(pattern)
        LocalDateTime.parse(this, formatter)
    } catch (e: DateTimeParseException) {
        null
    }