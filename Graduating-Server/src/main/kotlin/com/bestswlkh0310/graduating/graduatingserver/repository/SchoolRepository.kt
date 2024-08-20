package com.bestswlkh0310.graduating.graduatingserver.repository

import com.bestswlkh0310.graduating.graduatingserver.entity.SchoolEntity
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface SchoolRepository: JpaRepository<SchoolEntity, Long>