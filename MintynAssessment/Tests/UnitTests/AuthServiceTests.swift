import XCTest
@testable import MintynAssessment

final class AuthServiceTests: XCTestCase {
    
    func testLoginSuccess() {
        let authService = MockAuthService()
        let expectation = self.expectation(description: "Login should succeed")
        
        authService.login(phoneNumber: "8021234567", password: "password") { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testLoginFailure_InvalidCredentials() {
        let authService = MockAuthService()
        let expectation = self.expectation(description: "Login should fail with invalid credentials")
        
        authService.login(phoneNumber: "0000", password: "wrong") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error, .invalidCredentials)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testLoginFailure_EmptyFields() {
        let authService = MockAuthService()
        let expectation = self.expectation(description: "Login should fail with empty fields")
        
        authService.login(phoneNumber: "", password: "") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error, .invalidCredentials)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
