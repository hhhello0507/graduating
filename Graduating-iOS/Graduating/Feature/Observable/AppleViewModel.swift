import AuthenticationServices
import Foundation

final class AppleViewModel: NSObject, ObservableObject {
    @Published var error: Error?
    
    private var successCompletion: ((_ code: String) -> Void)?
    private var failureCompletion: (() -> Void)?
}

extension AppleViewModel {
    func signIn(
        successCompletion: @escaping (_ code: String) -> Void,
        failureCompletion: @escaping () -> Void
    ) {
        self.successCompletion = successCompletion
        self.failureCompletion = failureCompletion
        
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let c = ASAuthorizationController(authorizationRequests: [request])
        c.delegate = self
        c.presentationContextProvider = self
        c.performRequests()
    }
}

extension AppleViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            print("AppleSignInObservable - credential not found")
            failureCompletion?()
            return
        }
        
        guard let code = credential.authorizationCode,
              let codeString = String(data: code, encoding: .utf8) else {
            return
        }
        
        successCompletion?(codeString)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        self.error = error
        print("AppleSignInObservable - failure \(error)")
        failureCompletion?()
    }
}

extension AppleViewModel: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .compactMap({ $0.keyWindow })
            .first else {
            fatalError()
        }
        return window
    }
}
