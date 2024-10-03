package com.bestswlkh0310.graduating.graduatingserver.core.school

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Repository

@Repository
interface SchoolRepository : JpaRepository<SchoolEntity, Long>

fun SchoolRepository.getBy(id: Long) =
    findByIdOrNull(id) ?: throw Exception("No school with id $id")
