package com.bestswlkh0310.graduating.graduatingserver.api.school

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/school")
class SchoolController(
    private val schoolService: SchoolService
) {
    @GetMapping
    fun getSchools() = schoolService.getSchools()
}