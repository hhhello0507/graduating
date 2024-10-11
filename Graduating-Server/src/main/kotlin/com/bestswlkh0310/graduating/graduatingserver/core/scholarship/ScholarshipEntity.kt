package com.bestswlkh0310.graduating.graduatingserver.core.scholarship

import jakarta.persistence.*

@Entity
@Table(name = "tbl_scholarship")
class ScholarshipEntity(
    id: Long = 0,
    recruitmentStartDate: String,
    recruitmentEndDate: String,
    number: Int,
    productCategory: String,
    productName: String,
    selectionMethodDetails: String,
    selectionNumberDetails: String,
    gradeCriteriaDetails: String,
    incomeCriteriaDetails: String,
    operatingInstitutionCategory: String,
    operatingInstitutionName: String,
    qualificationRestrictionsDetails: String,
    requiredDocumentsDetails: String,
    residencyDetails: String,
    supportDetails: String,
    recommendationRequiredDetails: String,
    specificQualificationDetails: String,
    schoolCategory: String,
    gradeLevel: String,
    financialAidType: String,
    homepageUrl: String,
) {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Long = 0
        private set

    @Column(nullable = false)
    var recruitmentStartDate = recruitmentStartDate
        private set

    @Column(nullable = false)
    var recruitmentEndDate = recruitmentEndDate
        private set

    @Column(nullable = false)
    var number = number
        private set

    @Column(nullable = false)
    var productCategory = productCategory
        private set

    @Column(nullable = false)
    var productName = productName
        private set

    @Column(nullable = false, columnDefinition = "TEXT")
    var selectionMethodDetails = selectionMethodDetails
        private set

    @Column(nullable = false, columnDefinition = "TEXT")
    var selectionNumberDetails = selectionNumberDetails
        private set

    @Column(nullable = false, columnDefinition = "TEXT")
    var gradeCriteriaDetails = gradeCriteriaDetails
        private set

    @Column(nullable = false, columnDefinition = "TEXT")
    var incomeCriteriaDetails = incomeCriteriaDetails
        private set

    @Column(nullable = false)
    var operatingInstitutionCategory = operatingInstitutionCategory
        private set

    @Column(nullable = false)
    var operatingInstitutionName = operatingInstitutionName
        private set

    @Column(nullable = false, columnDefinition = "TEXT")
    var qualificationRestrictionsDetails = qualificationRestrictionsDetails
        private set

    @Column(nullable = false, columnDefinition = "TEXT")
    var requiredDocumentsDetails = requiredDocumentsDetails
        private set

    @Column(nullable = false, columnDefinition = "TEXT")
    var residencyDetails = residencyDetails
        private set

    @Column(nullable = false, columnDefinition = "TEXT")
    var supportDetails = supportDetails
        private set

    @Column(nullable = false, columnDefinition = "TEXT")
    var recommendationRequiredDetails = recommendationRequiredDetails
        private set

    @Column(nullable = false, columnDefinition = "TEXT")
    var specificQualificationDetails = specificQualificationDetails
        private set

    @Column(nullable = false)
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
}