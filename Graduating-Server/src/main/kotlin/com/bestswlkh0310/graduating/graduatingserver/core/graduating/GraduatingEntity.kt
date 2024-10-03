package com.bestswlkh0310.graduating.graduatingserver.core.graduating

import jakarta.persistence.*

@Entity
@Table(name = "graduating")
class GraduatingEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,
    @Column(nullable = false) val graduatingDay: String,

    // foreign key
    @Column(nullable = false) val schoolId: Long
)