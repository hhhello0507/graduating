package com.bestswlkh0310.graduating.graduatingserver.core.graduating

import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolEntity
import jakarta.persistence.*

@Entity
@Table(name = "tbl_graduating")
class GraduatingEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,
    
    @Column(nullable = false)
    val graduatingDay: String,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(nullable = false,  name = "school_id")
    val school: SchoolEntity,
)