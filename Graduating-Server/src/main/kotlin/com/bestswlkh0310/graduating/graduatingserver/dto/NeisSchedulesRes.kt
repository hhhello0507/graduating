package com.bestswlkh0310.graduating.graduatingserver.dto

import com.google.gson.annotations.SerializedName

data class NeisScheduleRowRes(
    @SerializedName("ATPT_OFCDC_SC_CODE") val atptOfcdcScCode: String,
    @SerializedName("SD_SCHUL_CODE") val sdSchulCode: String,
    val AY: String,
    @SerializedName("AA_YMD") val aaYmd: String,
    @SerializedName("ATPT_OFCDC_SC_NM") val atptOfcdcScNm: String,
    @SerializedName("SCHUL_NM") val schulNm: String,
    @SerializedName("DGHT_CRSE_SC_NM") val dghtCrseScNm: String,
    @SerializedName("SCHUL_CRSE_SC_NM") val schulCrseScNm: String,
    @SerializedName("EVENT_NM") val eventNm: String,
    @SerializedName("EVENT_CNTNT") val eventCntnt: String,
    @SerializedName("ONE_GRADE_EVENT_YN") val oneGradeEventYn: String,
    @SerializedName("TW_GRADE_EVENT_YN") val twGradeEventYn: String,
    @SerializedName("THREE_GRADE_EVENT_YN") val threeGradeEventYn: String,
    @SerializedName("FR_GRADE_EVENT_YN") val frGradeEventYn: String,
    @SerializedName("FIV_GRADE_EVENT_YN") val fivGradeEventYn: String,
    @SerializedName("SIX_GRADE_EVENT_YN") val sixGradeEventYn: String,
    @SerializedName("SBTR_DD_SC_NM") val sbtrDdScNm: String,
    @SerializedName("LOAD_DTM") val loadDtm: String
)

data class NeisScheduleRes(
    val row: List<NeisScheduleRowRes>
)

data class NeisSchedulesRes(
    @SerializedName("SchoolSchedule") val schoolSchedule: List<NeisScheduleRes?>?
)