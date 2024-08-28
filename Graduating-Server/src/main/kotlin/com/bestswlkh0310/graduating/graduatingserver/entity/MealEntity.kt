package com.bestswlkh0310.graduating.graduatingserver.entity

import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
@Table(name = "meal")
class MealEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,
    @Enumerated(value = EnumType.STRING) val mealType: MealType?,
    @Column(nullable = false) val calorie: Double,
    @Column(nullable = false, columnDefinition = "TEXT") val menu: String,
    @Column(nullable = false, columnDefinition = "TEXT") val mealInfo: String,
    @Column(nullable = false) val mealDate: LocalDateTime,

    // foreign key
    @Column(nullable = false) val schoolId: Long
)