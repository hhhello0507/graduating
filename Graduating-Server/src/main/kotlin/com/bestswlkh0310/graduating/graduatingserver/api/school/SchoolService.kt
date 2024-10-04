package com.bestswlkh0310.graduating.graduatingserver.api.school

import com.bestswlkh0310.graduating.graduatingserver.core.graduating.GraduatingEntity
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolEntity
import com.bestswlkh0310.graduating.graduatingserver.core.graduating.GraduatingRepository
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolRepository
import com.bestswlkh0310.graduating.graduatingserver.global.exception.CustomException
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service

@Service
class SchoolService(
    private val schoolRepository: SchoolRepository,
    private val graduatingRepository: GraduatingRepository
) {
    fun getSchools(): List<SchoolEntity> {
        return schoolRepository.findAll()
    }

    fun getGraduating(schoolId: Long): GraduatingEntity {
        return graduatingRepository.findBySchoolId(schoolId).firstOrNull()?: throw CustomException(HttpStatus.NOT_FOUND, "Not found graduating school")
    }
}