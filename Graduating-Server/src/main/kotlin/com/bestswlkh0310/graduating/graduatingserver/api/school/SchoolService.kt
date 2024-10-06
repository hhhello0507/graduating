package com.bestswlkh0310.graduating.graduatingserver.api.school

import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolEntity
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolRepository
import org.springframework.stereotype.Service

@Service
class SchoolService(
    private val schoolRepository: SchoolRepository,
) {
    fun getSchools(): List<SchoolEntity> {
        return schoolRepository.findAll()
    }
}