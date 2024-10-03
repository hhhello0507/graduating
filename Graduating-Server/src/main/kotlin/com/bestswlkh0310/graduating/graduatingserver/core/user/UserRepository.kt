package com.bestswlkh0310.graduating.graduatingserver.core.user

import com.bestswlkh0310.graduating.graduatingserver.global.exception.CustomException
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Repository

@Repository
interface UserRepository : JpaRepository<User, Long> {
    fun existsByUsername(username: String): Boolean
    fun findByUsername(username: String): List<User>
}

fun UserRepository.getByUsername(username: String): User =
    findByUsername(username).firstOrNull() ?: throw CustomException(HttpStatus.NOT_FOUND, "User not found")