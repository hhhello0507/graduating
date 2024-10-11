package com.bestswlkh0310.graduating.graduatingserver.api.scholarship.res

import com.bestswlkh0310.graduating.graduatingserver.core.scholarship.ScholarshipEntity
import com.bestswlkh0310.graduating.graduatingserver.core.scholarship.ScholarshipEntity.FinancialAidType
import com.bestswlkh0310.graduating.graduatingserver.core.scholarship.ScholarshipEntity.OperatingInstitutionCategory
import java.time.LocalDate

data class ScholarshipRes(
    val id: Long = 0,
    val recruitmentStartDate: LocalDate?,
    val recruitmentEndDate: LocalDate?,
    val productName: String,
    val selectionMethodDetails: String?,
    val selectionNumberDetails: String?,
    val gradeCriteriaDetails: String?,
    val incomeCriteriaDetails: String?,
    val operatingInstitutionCategory: OperatingInstitutionCategory,
    val operatingInstitutionName: String,
    val qualificationRestrictionsDetails: String?,
    val requiredDocumentsDetails: String?,
    val residencyDetails: String?,
    val supportDetails: String?,
    val recommendationRequiredDetails: String?,
    val specificQualificationDetails: String?,
    val schoolCategory: List<String>,
    val gradeLevel: List<String>,
    val financialAidType: FinancialAidType,
    val homepageUrl: String,
) {
    companion object {
        fun of(entity: ScholarshipEntity) = ScholarshipRes(
            id = entity.id,
            recruitmentStartDate = entity.recruitmentStartDate,
            recruitmentEndDate = entity.recruitmentEndDate,
            productName = entity.productName,
            selectionMethodDetails = entity.selectionMethodDetails,
            selectionNumberDetails = entity.selectionNumberDetails,
            gradeCriteriaDetails = entity.gradeLevel,
            incomeCriteriaDetails = entity.incomeCriteriaDetails,
            operatingInstitutionCategory = entity.operatingInstitutionCategory,
            operatingInstitutionName = entity.operatingInstitutionName,
            qualificationRestrictionsDetails = entity.qualificationRestrictionsDetails,
            requiredDocumentsDetails = entity.requiredDocumentsDetails,
            residencyDetails = entity.residencyDetails,
            supportDetails = entity.supportDetails,
            recommendationRequiredDetails = entity.recommendationRequiredDetails,
            specificQualificationDetails = entity.specificQualificationDetails,
            schoolCategory = entity.schoolCategory?.split("/") ?: emptyList(),
            gradeLevel = entity.gradeLevel.split("/"),
            financialAidType = entity.financialAidType,
            homepageUrl = entity.homepageUrl,
        )
    }
}