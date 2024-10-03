package com.bestswlkh0310.graduating.graduatingserver.api.auth

import com.bestswlkh0310.graduating.graduatingserver.api.auth.req.OAuth2SignInReq
import com.bestswlkh0310.graduating.graduatingserver.api.auth.req.RefreshReq
import com.bestswlkh0310.graduating.graduatingserver.api.auth.req.SignInReq
import com.bestswlkh0310.graduating.graduatingserver.api.auth.req.SignUpReq
import jakarta.validation.Valid
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/auth")
class AuthController(
    private val authService: AuthService
) {
    @PostMapping("/sign-up")
    fun signUp(@RequestBody @Valid req: SignUpReq) =
        authService.signUp(req)

    @PostMapping("/sign-in")
    fun signIn(@RequestBody @Valid req: SignInReq) =
        authService.signIn(req)

    @PostMapping("/refresh")
    fun refresh(@RequestBody @Valid req: RefreshReq) =
        authService.refresh(req)

    @PostMapping("/sign-in/oauth2")
    fun oAuth2SignIn(@RequestBody @Valid req: OAuth2SignInReq) =
        authService.oAuth2SignIn(req)
}