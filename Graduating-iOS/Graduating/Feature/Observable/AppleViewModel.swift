import AuthenticationServices
import Combine
import Foundation

import MyUIKitExt

final class AppleViewModel: NSObject, ObservableObject {
    enum Subject {
        case signInSuccess(code: String)
        case signInFailure
    }
    
    @Published var error: Error?
    var subject = PassthroughSubject<Subject, Never>()
}

extension AppleViewModel {
    func signIn() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

extension AppleViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            print("\(#file) - credential not found")
            self.subject.send(.signInFailure)
            return
        }
        
        guard let code = credential.authorizationCode,
              let codeString = String(data: code, encoding: .utf8) else {
            print("\(#file) - Can't decode code")
            self.subject.send(.signInFailure)
            return
        }
        
        self.subject.send(.signInSuccess(code: codeString))
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        self.error = error
        print("\(#file) - failure \(error)")
        self.subject.send(.signInFailure)
    }
}

extension AppleViewModel: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = UIApplicationUtil.window else { fatalError() }
        return window
    }
}
