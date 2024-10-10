package com.bestswlkh0310.graduating.graduatingserver.entity

import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolEntity
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolType
import java.time.LocalDate

class SchoolEntityTest {
    companion object {
        val name = "schoolName"
        val cityName = "cityName"
        val postalCode = "postalCode"
        val address = "address"
        val addressDetail = "addressDetail"
        val phone = "010-0000-0000"
        val website = "about:blank"
        val createdAt = LocalDate.now()
        val anniversary = LocalDate.now()
        val code = "code"
        val officeCode = "officeCode"
        
        val highSchool = SchoolEntity(
            name = name,
            type = SchoolType.HIGH,
            cityName = cityName,
            postalCode = postalCode,
            address = address,
            addressDetail = addressDetail,
            phone = phone,
            website = website,
            createdAt = createdAt,
            anniversary = anniversary,
            code = code,
            officeCode = officeCode,
        )
        
        val middleSchool = SchoolEntity(
            name = name,
            type = SchoolType.MIDDLE,
            cityName = cityName,
            postalCode = postalCode,
            address = address,
            addressDetail = addressDetail,
            phone = phone,
            website = website,
            createdAt = createdAt,
            anniversary = anniversary,
            code = code,
            officeCode = officeCode,
        )

        val elementarySchool = SchoolEntity(
            name = name,
            type = SchoolType.ELEMENTARY,
            cityName = cityName,
            postalCode = postalCode,
            address = address,
            addressDetail = addressDetail,
            phone = phone,
            website = website,
            createdAt = createdAt,
            anniversary = anniversary,
            code = code,
            officeCode = officeCode,
        )
    }
}