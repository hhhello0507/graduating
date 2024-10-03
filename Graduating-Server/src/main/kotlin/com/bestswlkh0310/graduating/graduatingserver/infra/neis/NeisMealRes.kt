package com.bestswlkh0310.graduating.graduatingserver.infra.neis

data class NeisMealRowRes(
    val ATPT_OFCDC_SC_CODE: String,
    val ATPT_OFCDC_SC_NM: String,
    val SD_SCHUL_CODE: String,
    val SCHUL_NM: String,
    val MMEAL_SC_CODE: String,
    val MMEAL_SC_NM: String,
    val MLSV_YMD: String,
    val MLSV_FGR: Double,
    val DDISH_NM: String,
    val ORPLC_INFO: String,
    val CAL_INFO: String,
    val NTR_INFO: String,
    val MLSV_FROM_YMD: String,
    val MLSV_TO_YMD: String,
    val LOAD_DTM: String
)

data class NeisMealRes(
    val row: List<NeisMealRowRes?>
)

data class NeisMealsRes(
    val mealServiceDietInfo: List<NeisMealRes?>?,
)