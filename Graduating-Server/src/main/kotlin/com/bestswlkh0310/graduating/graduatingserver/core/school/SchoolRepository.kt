package com.bestswlkh0310.graduating.graduatingserver.core.school

import com.bestswlkh0310.graduating.graduatingserver.global.exception.CustomException
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Repository

@Repository
interface SchoolRepository : JpaRepository<SchoolEntity, Long>

fun SchoolRepository.getBy(id: Long) =
    findByIdOrNull(id) ?: throw CustomException(HttpStatus.NOT_FOUND, "Not found school")
