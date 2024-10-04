package com.bestswlkh0310.graduating.graduatingserver.core.school

import jakarta.persistence.*
import java.time.LocalDate

@Entity
@Table(name = "tbl_school")
class SchoolEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @Column(nullable = false) val name: String,
    @Enumerated(value = EnumType.STRING) val type: SchoolType?,
    @Column(nullable = false) val cityName: String,
    @Column(nullable = false) val postalCode: String,
    @Column(nullable = false) val address: String,
    @Column(nullable = false) val addressDetail: String,
    @Column(nullable = false) val phone: String,
    @Column(nullable = false) val website: String,
    @Column(nullable = false) val createdAt: LocalDate,
    @Column(nullable = false) val anniversary: LocalDate,
    @Column(nullable = false) val code: String,
    @Column(nullable = false) val officeCode: String
)