package com.bestswlkh0310.graduating.graduatingserver.core.global

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.transaction.annotation.Transactional

@Transactional
fun <T : Any, ID> JpaRepository<T, ID>.safeSaveAll(entities: Iterable<T>) {
    entities.forEach {
        try {
            save(it)
        } catch (_: Exception) {
        }
    }
}