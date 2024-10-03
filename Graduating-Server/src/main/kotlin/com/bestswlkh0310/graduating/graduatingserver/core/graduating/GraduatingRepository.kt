package com.bestswlkh0310.graduating.graduatingserver.core.graduating

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface GraduatingRepository: JpaRepository<GraduatingEntity, Long> {
    fun findBySchoolId(schoolId: Long): List<GraduatingEntity>
}