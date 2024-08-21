package com.bestswlkh0310.graduating.graduatingserver.service

import com.bestswlkh0310.graduating.graduatingserver.entity.GraduatingEntity
import com.bestswlkh0310.graduating.graduatingserver.entity.SchoolEntity
import com.bestswlkh0310.graduating.graduatingserver.repository.GraduatingRepository
import com.bestswlkh0310.graduating.graduatingserver.repository.SchoolRepository
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
        return graduatingRepository.findBySchoolId(schoolId).firstOrNull()?: throw Exception("404") // TODO: Create CustomException
    }
}