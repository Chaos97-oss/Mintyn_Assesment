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
    func login(phoneNumber: String?, password: String?) {
        guard let phoneNumber = phoneNumber, !phoneNumber.isEmpty, phoneNumber.count >= 10 else {
            onError?("Please enter your phone number.")
            return
        }
        guard let password = password, !password.isEmpty else {
            onError?("Please enter your password.")
            return
        }
        
        isLoading = true
        
        authService.login(phoneNumber: phoneNumber, password: password) { [weak self] result in
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
