package com.bestswlkh0310.graduating.graduatingserver.core.global

import org.springframework.data.jpa.repository.JpaRepository

fun <T : Any, ID> JpaRepository<T, ID>.safeSaveAll(entities: Iterable<T>) {
    entities.forEach {
        try {
            save(it)
        } catch (_: Exception) {
        }
    }
}