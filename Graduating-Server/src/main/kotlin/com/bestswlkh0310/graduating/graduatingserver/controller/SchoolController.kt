package com.bestswlkh0310.graduating.graduatingserver.controller

import com.bestswlkh0310.graduating.graduatingserver.service.SchoolService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/school")
class SchoolController(
    private val schoolService: SchoolService
) {
    @GetMapping("", "/")
    fun getSchools() = schoolService.getSchools()

    @GetMapping("graduating", "graduating/")
    fun getGraduatingSchools(@RequestParam("id") id: Long, ) = schoolService.getGraduating(id)
}