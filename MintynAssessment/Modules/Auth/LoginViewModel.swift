import Foundation

class LoginViewModel {
    
    // MARK: - Dependencies
    private let authService: AuthServiceProtocol
    
    // MARK: - Outputs (Bindings)
    var onLoadingStateChanged: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    var onSuccess: (() -> Void)?
    
    // MARK: - State
    private var isLoading: Bool = false {
        didSet {
            onLoadingStateChanged?(isLoading)
        }
    }
    
    // MARK: - Initialization
    init(authService: AuthServiceProtocol = MockAuthService()) {
        self.authService = authService
    }
    
    // MARK: - Logic
    func login(email: String?, password: String?) {
        guard let email = email, !email.isEmpty else {
            onError?("Please enter your email.")
            return
        }
        guard let password = password, !password.isEmpty else {
            onError?("Please enter your password.")
            return
        }
        
        isLoading = true
        
        authService.login(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success:
                self.onSuccess?()
            case .failure(let error):
                self.onError?(error.localizedDescription)
            }
        }
    }
}
