package com.bestswlkh0310.graduating.graduatingserver.core.meal

import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolEntity
import jakarta.persistence.*
import java.time.LocalDate

@Entity
@Table(
    name = "tbl_meal",
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
    
    @Enumerated(value = EnumType.STRING) 
    val mealType: MealType?,
    
    @Column(nullable = false) 
    val calorie: Double,
    
    @Column(nullable = false, columnDefinition = "TEXT")
    val menu: String,
    
    @Column(nullable = false, columnDefinition = "TEXT")
    val mealInfo: String,
    
    @Column(nullable = false)
    val mealDate: LocalDate,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "school_id", nullable = false)
    val school: SchoolEntity,
)