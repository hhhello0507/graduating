package com.bestswlkh0310.graduating.graduatingserver.infra.neis.meal

import com.bestswlkh0310.graduating.graduatingserver.common.toLocalDate
import com.bestswlkh0310.graduating.graduatingserver.core.meal.MealEntity
import com.bestswlkh0310.graduating.graduatingserver.core.meal.MealType
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolEntity
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.annotation.JsonProperty

data class NeisMealsRes(
    val mealServiceDietInfo: List<MealServiceDietInfo?>
) {
    @JsonIgnoreProperties(ignoreUnknown = true)
    data class MealServiceDietInfo(
        val row: List<Row>?
    ) {
        data class Row(
            /**
             * 시도교육청코드
             */
            @JsonProperty("ATPT_OFCDC_SC_CODE") val atptOfcdcScCode: String,
            
            /**
             * 시도교육청명
             */
            @JsonProperty("ATPT_OFCDC_SC_NM") val atptOfcdcScNm: String,

            /**
             * 칼로리정보
             */
            @JsonProperty("CAL_INFO") val calInfo: String,

            /**
             * 요리명
             */
            @JsonProperty("DDISH_NM") val ddishNm: String,

            /**
             * 수정일자
             */
            @JsonProperty("LOAD_DTM") val loadDtm: String,

            /**
             * 급식인원수
             */
            @JsonProperty("MLSV_FGR") val mlsvFgr: Int,

            /**
             * 급식시작일자
             */
            @JsonProperty("MLSV_FROM_YMD") val mlsvFromYmd: String,

            /**
             * 급식종료일자
             */
            @JsonProperty("MLSV_TO_YMD") val mlsvToYmd: String,

            /**
             * 급식일자
             */
            @JsonProperty("MLSV_YMD") val mlsvYmd: String,

            /**
             * 식사코드
             */
            @JsonProperty("MMEAL_SC_CODE") val mmealScCode: String,

            /**
             * 식사명
             */
            @JsonProperty("MMEAL_SC_NM") val mmealScNm: String,

            /**
             * 영양정보
             */
            @JsonProperty("NTR_INFO") val ntrInfo: String,
            
            /**
             * 원산지정보
             */
            @JsonProperty("ORPLC_INFO") val orplcInfo: String,
            
            /**
             * 학교명
             */
            @JsonProperty("SCHUL_NM") val schulNm: String,
            
            /**
             * 행정표준코드
             */
            @JsonProperty("SD_SCHUL_CODE") val sdSchulCode: String
        ) {
            fun toEntity(school: SchoolEntity): MealEntity? {
                val time = this.mlsvToYmd.toLocalDate("yyyyMMdd") ?: return null
                return MealEntity(
                    mealType = MealType.ofKorean(this.mmealScNm),
                    menu = this.ddishNm,
                    calorie = this.calInfo.substringBefore(" Kcal").toDoubleOrNull() ?: 0.0,
                    mealInfo = this.orplcInfo,
                    mealDate = time,
                    school = school
                )
            }
        }
    }
}