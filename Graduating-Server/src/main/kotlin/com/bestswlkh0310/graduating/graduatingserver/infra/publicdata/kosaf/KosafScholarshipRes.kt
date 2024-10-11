package com.bestswlkh0310.graduating.graduatingserver.infra.publicdata.kosaf

import com.bestswlkh0310.graduating.graduatingserver.core.scholarship.ScholarshipEntity
import com.fasterxml.jackson.annotation.JsonProperty

data class KosafScholarshipRes(
    val currentCount: Int,
    val `data`: List<Data>,
    val matchCount: Int,
    val page: Int,
    val perPage: Int,
    val totalCount: Int
) {
    data class Data(
        @JsonProperty("모집시작일") val recruitmentStartDate: String,
        @JsonProperty("모집종료일") val recruitmentEndDate: String,
        @JsonProperty("번호") val number: Int,
        @JsonProperty("상품구분") val productCategory: String,
        @JsonProperty("상품명") val productName: String,
        @JsonProperty("선발방법 상세내용") val selectionMethodDetails: String,
        @JsonProperty("선발인원 상세내용") val selectionNumberDetails: String,
        @JsonProperty("성적기준 상세내용") val gradeCriteriaDetails: String,
        @JsonProperty("소득기준 상세내용") val incomeCriteriaDetails: String,
        @JsonProperty("운영기관구분") val operatingInstitutionCategory: String,
        @JsonProperty("운영기관명") val operatingInstitutionName: String,
        @JsonProperty("자격제한 상세내용") val qualificationRestrictionsDetails: String,
        @JsonProperty("제출서류 상세내용") val requiredDocumentsDetails: String,
        @JsonProperty("지역거주여부 상세내용") val residencyDetails: String,
        @JsonProperty("지원내역 상세내용") val supportDetails: String,
        @JsonProperty("추천필요여부 상세내용") val recommendationRequiredDetails: String,
        @JsonProperty("특정자격 상세내용") val specificQualificationDetails: String,
        @JsonProperty("학교구분") val schoolCategory: String,
        @JsonProperty("학년구분") val gradeLevel: String,
        @JsonProperty("학자금유형구분") val financialAidType: String,
        @JsonProperty("홈페이지주소") val homepageUrl: String
    ) {
        fun toEntity() = ScholarshipEntity(
            recruitmentStartDate = this.recruitmentStartDate,
            recruitmentEndDate = this.recruitmentEndDate,
            number = this.number,
            productCategory = this.productCategory,
            productName = this.productName,
            selectionMethodDetails = this.selectionMethodDetails,
            selectionNumberDetails = this.selectionNumberDetails,
            gradeCriteriaDetails = this.gradeCriteriaDetails,
            incomeCriteriaDetails = this.incomeCriteriaDetails,
            operatingInstitutionCategory = this.operatingInstitutionCategory,
            operatingInstitutionName = this.operatingInstitutionName,
            qualificationRestrictionsDetails = this.qualificationRestrictionsDetails,
            requiredDocumentsDetails = this.requiredDocumentsDetails,
            residencyDetails = this.residencyDetails,
            supportDetails = this.supportDetails,
            recommendationRequiredDetails = this.recommendationRequiredDetails,
            specificQualificationDetails = this.specificQualificationDetails,
            schoolCategory = schoolCategory,
            gradeLevel = this.gradeLevel,
            financialAidType = this.financialAidType,
            homepageUrl = this.homepageUrl
        )
    }
}