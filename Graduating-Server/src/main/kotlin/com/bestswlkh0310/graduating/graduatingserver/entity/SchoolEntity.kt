package com.bestswlkh0310.graduating.graduatingserver.entity

import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
@Table(name = "school")
class SchoolEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @Column(nullable = false)
    val name: String,

    @Enumerated(EnumType.STRING)
    val type: SchoolType?,

    @Column(nullable = false)
    val cityName: String,

    @Column(nullable = false)
    val postalCode: String,

    @Column(nullable = false)
    val address: String,

    @Column(nullable = false)
    val addressDetail: String,

    @Column(nullable = false)
    val phone: String,

    @Column(nullable = false)
    val website: String,

    @Column(nullable = false)
    val createdAt: String,

    @Column(nullable = false)
    val anniversary: String
)