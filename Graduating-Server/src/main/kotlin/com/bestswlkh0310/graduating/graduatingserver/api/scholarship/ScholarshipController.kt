package com.bestswlkh0310.graduating.graduatingserver.api.scholarship

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/scholarships")
class ScholarshipController(
    private val scholarshipService: ScholarshipService
) {
    @GetMapping
    fun scholarships() =
        scholarshipService.getScholarships()
}