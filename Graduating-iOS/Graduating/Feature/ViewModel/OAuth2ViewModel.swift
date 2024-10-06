import AuthenticationServices
import Combine
import Foundation
import MyUIKitExt
import Shared
import GoogleSignIn

enum AppleSignInError: Error {
    case credentialNotFound
    case canNotDecode
}

enum GoogleSignInError: Error {
    case notFoundRootViewController
    case unknown(Error)
}

final class OAuth2ViewModel: NSObject, ObservableObject {
    @Published var appleSignInFlow: Resource<String> = .idle
    @Published var googleSignInFlow: Resource<String> = .idle
    
    var isFetching: Bool {
        appleSignInFlow == .fetching || googleSignInFlow == .fetching
    }
}

extension OAuth2ViewModel {
    func appleSignIn() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    @MainActor
    func googleSignIn() {
        guard let rootViewController = UIApplicationUtil.window?.rootViewController else {
            self.googleSignInFlow = .failure(GoogleSignInError.notFoundRootViewController)
            return
        }
        Task {
            do {
                let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
                guard let code = result.serverAuthCode else { return }
                self.googleSignInFlow = .success(code)
            } catch {
                self.googleSignInFlow = .failure(GoogleSignInError.unknown(error))
            }
        }
    }
}

extension OAuth2ViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            print("\(#file) - credential not found")
            self.appleSignInFlow = .failure(AppleSignInError.credentialNotFound)
            return
        }
        guard let code = credential.authorizationCode,
              let codeString = String(data: code, encoding: .utf8) else {
            print("\(#file) - Can't decode code")
            self.appleSignInFlow = .failure(AppleSignInError.canNotDecode)
            return
        }
        
        self.appleSignInFlow = .success(codeString)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        self.appleSignInFlow = .failure(error)
        print("\(#file) - failure \(error)")
    }
}

extension OAuth2ViewModel: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = UIApplicationUtil.window else { fatalError() }
        return window
    }
}
