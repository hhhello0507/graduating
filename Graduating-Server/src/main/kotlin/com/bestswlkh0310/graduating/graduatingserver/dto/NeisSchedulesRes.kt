package com.bestswlkh0310.graduating.graduatingserver.dto

data class NeisScheduleRowRes(
    val ATPT_OFCDC_SC_CODE: String,
    val SD_SCHUL_CODE: String,
    val AY: String,
    val AA_YMD: String,
    val ATPT_OFCDC_SC_NM: String,
    val SCHUL_NM: String,
    val DGHT_CRSE_SC_NM: String,
    val SCHUL_CRSE_SC_NM: String,
    val EVENT_NM: String,
    val EVENT_CNTNT: String,
    val ONE_GRADE_EVENT_YN: String,
    val TW_GRADE_EVENT_YN: String,
    val THREE_GRADE_EVENT_YN: String,
    val FR_GRADE_EVENT_YN: String,
    val FIV_GRADE_EVENT_YN: String,
    val SIX_GRADE_EVENT_YN: String,
    val SBTR_DD_SC_NM: String,
    val LOAD_DTM: String
)

data class NeisScheduleRes(
    val row: List<NeisScheduleRowRes>
)

data class NeisSchedulesRes(
    val SchoolSchedule: List<NeisScheduleRes?>?
)