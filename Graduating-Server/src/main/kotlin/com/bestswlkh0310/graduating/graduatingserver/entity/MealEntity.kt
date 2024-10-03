package com.bestswlkh0310.graduating.graduatingserver.entity

import jakarta.persistence.*
import java.time.LocalDate

@Entity
@Table(
    name = "meal",
    uniqueConstraints = [
        UniqueConstraint(
            name = "UniqueMealDateAndMealTypeAndSchoolId",
            columnNames = ["mealDate", "mealType", "school_id"]
        )
    ]
)
class MealEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,
    @Enumerated(value = EnumType.STRING) val mealType: MealType?,
    @Column(nullable = false) val calorie: Double,
    @Column(nullable = false, columnDefinition = "TEXT") val menu: String,
    @Column(nullable = false, columnDefinition = "TEXT") val mealInfo: String,
    @Column(nullable = false) val mealDate: LocalDate,

    // foreign key
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "school_id", nullable = false)
    val school: SchoolEntity,
)