import Foundation

enum AuthError: Error {
    case invalidCredentials
    case timeout
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .invalidCredentials: return "Invalid email or password."
        case .timeout: return "Request timed out."
        case .unknown: return "An unknown error occurred."
        }
    }
}

protocol AuthServiceProtocol {
    func login(phoneNumber: String, password: String, completion: @escaping (Result<Void, AuthError>) -> Void)
}

final class MockAuthService: AuthServiceProtocol {
    func login(phoneNumber: String, password: String, completion: @escaping (Result<Void, AuthError>) -> Void) {
        // Simulate network delay
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            // Basic mock validation
            if phoneNumber.isEmpty || password.isEmpty {
                DispatchQueue.main.async { completion(.failure(.invalidCredentials)) }
                return
            }
            if phoneNumber == "8021234567" && password == "password" {
                DispatchQueue.main.async { completion(.success(())) }
            } else {
                DispatchQueue.main.async { completion(.failure(.invalidCredentials)) }
            }
        }
    }
}
