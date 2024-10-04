package com.bestswlkh0310.graduating.graduatingserver.infra.neis.schedule

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.annotation.JsonProperty


data class NeisSchedulesRes(
    @JsonProperty("SchoolSchedule") val schoolSchedule: List<SchoolSchedule>
) {
    @JsonIgnoreProperties(ignoreUnknown = true)
    data class SchoolSchedule(
        val row: List<Row>?
    ) {
        data class Row(
            /**
             * 시도교육청코드
             */
            @JsonProperty("ATPT_OFCDC_SC_CODE") val atptOfcdcScCode: String,

            /**
             * 행정표준코드
             */
            @JsonProperty("SD_SCHUL_CODE") val sdSchulCode: String,

            /**
             * 학년도
             */
            @JsonProperty("AY") val ay: String,

            /**
             * 학사일자
             */
            @JsonProperty("AA_YMD") val aaYmd: String,

            /**
             * 시도교육청명
             */
            @JsonProperty("ATPT_OFCDC_SC_NM") val atptOfcdcScNm: String,

            /**
             * 학교명
             */
            @JsonProperty("SCHUL_NM") val schulNm: String,

            /**
             * 주야과정명
             */
            @JsonProperty("DGHT_CRSE_SC_NM") val dghtCrseScNm: String,

            /**
             * 학교과정명
             */
            @JsonProperty("SCHUL_CRSE_SC_NM") val schulCrseScNm: String,

            /**
             * 행사명
             */
            @JsonProperty("EVENT_NM") val eventNm: String,

            /**
             * 행사내용
             */
            @JsonProperty("EVENT_CNTNT") val eventCntnt: String,

            /**
             * 1학년행사여부
             */
            @JsonProperty("ONE_GRADE_EVENT_YN") val oneGradeEventYn: String,

            /**
             * 2학년행사여부
             */
            @JsonProperty("TW_GRADE_EVENT_YN") val twGradeEventYn: String,

            /**
             * 3학년행사여부
             */
            @JsonProperty("THREE_GRADE_EVENT_YN") val threeGradeEventYn: String,

            /**
             * 4학년행사여부
             */
            @JsonProperty("FR_GRADE_EVENT_YN") val frGradeEventYn: String,

            /**
             * 5학년행사여부
             */
            @JsonProperty("FIV_GRADE_EVENT_YN") val fivGradeEventYn: String,

            /**
             * 6학년행사여부
             */
            @JsonProperty("SIX_GRADE_EVENT_YN") val sixGradeEventYn: String,

            /**
             * 수업공제일명
             */
            @JsonProperty("SBTR_DD_SC_NM") val sbtrDdScNm: String,

            /**
             * 수정일자
             */
            @JsonProperty("LOAD_DTM") val loadDtm: String
        )
    }
}