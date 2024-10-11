package com.bestswlkh0310.graduating.graduatingserver.api.scholarship

import com.bestswlkh0310.graduating.graduatingserver.api.scholarship.res.ScholarshipRes
import com.bestswlkh0310.graduating.graduatingserver.core.scholarship.ScholarshipRepository
import org.springframework.stereotype.Service

@Service
class ScholarshipService(
    private val scholarshipRepository: ScholarshipRepository
) {
    fun getScholarships(): List<ScholarshipRes> =
        scholarshipRepository.findAll()
            .map(ScholarshipRes::of)
}