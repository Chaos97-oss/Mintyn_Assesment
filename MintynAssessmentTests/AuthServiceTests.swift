import XCTest
@testable import MintynAssessment

class AuthServiceTests: XCTestCase {
    
    var authService: MockAuthService!
    
    override func setUp() {
        super.setUp()
        authService = MockAuthService()
    }
    
    override func tearDown() {
        authService = nil
        super.tearDown()
    }
    
    func testLogin_WithValidCredentials_ReturnsSuccess() {
        let expectation = XCTestExpectation(description: "Login Success")
        
        authService.login(email: "admin@mintyn.com", password: "password123") { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("Valid credentials should not fail")
            }
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testLogin_WithInvalidPassword_ReturnsError() {
        let expectation = XCTestExpectation(description: "Login Failure")
        
        authService.login(email: "admin@mintyn.com", password: "wrong_password") { result in
            switch result {
            case .success:
                XCTFail("Invalid credentials should not succeed")
            case .failure(let error):
                XCTAssertEqual(error, .invalidCredentials)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testLogin_WithEmptyFields_ReturnsError() {
        let expectation = XCTestExpectation(description: "Login Empty Fields")
        
        authService.login(email: "", password: "") { result in
            switch result {
            case .success:
                XCTFail("Empty credentials should not succeed")
            case .failure(let error):
                XCTAssertEqual(error, .invalidCredentials)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}
