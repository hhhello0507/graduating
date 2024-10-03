package com.bestswlkh0310.graduating.graduatingserver.global.exception

import com.bestswlkh0310.graduating.graduatingserver.global.ErrorRes
import com.fasterxml.jackson.databind.ObjectMapper
import jakarta.servlet.http.HttpServletResponse
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.stereotype.Component
import java.io.IOException

@Component
class ErrorResponseSender(
    private val objectMapper: ObjectMapper
) {

    fun send(response: HttpServletResponse, customException: CustomException) =
        send(response, customException.status, customException.message)

    fun send(response: HttpServletResponse, status: HttpStatus, message: String? = null) {
        try {
            response.apply {
                this.status = status.value()
                contentType = MediaType.APPLICATION_JSON_VALUE
                characterEncoding = "UTF-8"
            }
            response.writer.write(
                objectMapper.writeValueAsString(
                    ErrorRes(
                        status = status.value(),
                        message = message ?: status.reasonPhrase
                    )
                )
            )
        } catch (e: IOException) {
            e.printStackTrace()
        }
    }
}