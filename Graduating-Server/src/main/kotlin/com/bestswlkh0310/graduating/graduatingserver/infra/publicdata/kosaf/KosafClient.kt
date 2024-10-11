package com.bestswlkh0310.graduating.graduatingserver.infra.publicdata.kosaf

import com.bestswlkh0310.graduating.graduatingserver.core.scholarship.ScholarshipEntity
import com.bestswlkh0310.graduating.graduatingserver.infra.publicdata.PublicDataProperties
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.stereotype.Component
import org.springframework.web.client.RestClient

@Component
class KosafClient(
    private val publicDataProperties: PublicDataProperties,
    @Qualifier("public-data")
    private val restClient: RestClient
) {

    fun fetchScholarships(
        uuid: String
    ): List<ScholarshipEntity> {
        return restClient.get()
            .uri { uriBuilder ->
                // 왜 uddi인지 모르겠음
                uriBuilder.path("api/15116988/v1/uddi:$uuid")
                    .queryParam("page", 1)
                    .queryParam("perPage", 10000)
                    .queryParam("returnType", "json")
                    .build()
            }
            .headers { headers ->
                headers.set("Authorization", "Infuser ${publicDataProperties.kosafServiceKey}")
            }
            .retrieve()
            .body(KosafScholarshipRes::class.java)!! // Force 500
            .data
            .map { it.toEntity() }
    }
}