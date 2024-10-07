package com.bestswlkh0310.graduating.graduatingserver.api.user

import com.bestswlkh0310.graduating.graduatingserver.api.user.dto.EditUserReq
import jakarta.validation.Valid
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PatchMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/user")
class UserController(
    private val userService: UserService
) {
    @GetMapping("me")
    fun getMe() =
        userService.getMe()

    @PatchMapping
    fun editUser(@Valid @RequestBody req: EditUserReq) =
        userService.editUser(req)
}