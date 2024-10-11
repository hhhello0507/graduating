package com.bestswlkh0310.graduating.graduatingserver.core.scholarship

import jakarta.persistence.*
import java.time.LocalDate

@Entity
@Table(name = "tbl_scholarship")
class ScholarshipEntity(
    id: Long = 0,
    recruitmentStartDate: LocalDate?,
    recruitmentEndDate: LocalDate?,
    productName: String,
    selectionMethodDetails: String?,
    selectionNumberDetails: String?,
    gradeCriteriaDetails: String?,
    incomeCriteriaDetails: String?,
    operatingInstitutionCategory: OperatingInstitutionCategory,
    operatingInstitutionName: String,
    qualificationRestrictionsDetails: String?,
    requiredDocumentsDetails: String?,
    residencyDetails: String?,
    supportDetails: String?,
    recommendationRequiredDetails: String?,
    specificQualificationDetails: String?,
    schoolCategory: String?,
    gradeLevel: String,
    financialAidType: FinancialAidType,
    homepageUrl: String,
) {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Long = 0
        private set

    var recruitmentStartDate = recruitmentStartDate
        private set

    var recruitmentEndDate = recruitmentEndDate
        private set

    @Column(nullable = false)
    var productName = productName
        private set

    @Column(columnDefinition = "TEXT")
    var selectionMethodDetails = selectionMethodDetails
        private set

    @Column(columnDefinition = "TEXT")
    var selectionNumberDetails = selectionNumberDetails
        private set

    @Column(columnDefinition = "TEXT")
    var gradeCriteriaDetails = gradeCriteriaDetails
        private set

    @Column(columnDefinition = "TEXT")
    var incomeCriteriaDetails = incomeCriteriaDetails
        private set

    @Column(nullable = false)
    var operatingInstitutionCategory = operatingInstitutionCategory
        private set

    @Column(nullable = false)
    var operatingInstitutionName = operatingInstitutionName
        private set

    @Column(columnDefinition = "TEXT")
    var qualificationRestrictionsDetails = qualificationRestrictionsDetails
        private set

    @Column(columnDefinition = "TEXT")
    var requiredDocumentsDetails = requiredDocumentsDetails
        private set

    @Column(columnDefinition = "TEXT")
    var residencyDetails = residencyDetails
        private set

    @Column(columnDefinition = "TEXT")
    var supportDetails = supportDetails
        private set

    @Column(columnDefinition = "TEXT")
    var recommendationRequiredDetails = recommendationRequiredDetails
        private set

    @Column(columnDefinition = "TEXT")
    var specificQualificationDetails = specificQualificationDetails
        private set

    var schoolCategory = schoolCategory
        private set

    @Column(nullable = false)
    var gradeLevel = gradeLevel
        private set

    @Column(nullable = false)
    var financialAidType = financialAidType
        private set

    @Column(nullable = false)
    var homepageUrl = homepageUrl
        private set
    
    enum class FinancialAidType(
        val korean: String
    ) {
        LOCAL(korean = "지역연고"),
        SPECIAL(korean = "특기자"),
        INCOME_CLASSIFICATION(korean = "소득구분"),
        GOOD_SCORE(korean = "성적우수"),
        OTHER(korean = "기타"),
        DISABLED(korean = "장애인");

        companion object {
            fun fromKorean(korean: String) = FinancialAidType.entries.firstOrNull { it.korean == korean }
        }
    }
    
    enum class OperatingInstitutionCategory(
        val korean: String
    ) {
        LOCAL_GOVERNMENT(korean = "지자체"),
        PRIVATE_CORPORATION(korean = "민간(기업)"),
        PRIVATE_OTHER(korean = "민간(기타)"),
        RELATED_MINISTRIES(korean = "관계부처"),
        KOSAF(korean = "한국장학재단"),
        UNIVERSITY(korean = "대학교");
        
        companion object {
            fun fromKorean(korean: String) = entries.firstOrNull { it.korean == korean }
        }
    }
}