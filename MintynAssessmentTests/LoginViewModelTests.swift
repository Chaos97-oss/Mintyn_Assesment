import XCTest
@testable import MintynAssessment

class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    var mockAuthService: MockAuthService!
    
    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthService()
        viewModel = LoginViewModel(authService: mockAuthService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAuthService = nil
        super.tearDown()
    }
    
    func testLogin_EmptyEmail_TriggersError() {
        var receivedError: String?
        viewModel.onError = { error in
            receivedError = error
        }
        
        viewModel.login(email: "", password: "password123")
        XCTAssertEqual(receivedError, "Please enter your email.")
    }
    
    func testLogin_EmptyPassword_TriggersError() {
        var receivedError: String?
        viewModel.onError = { error in
            receivedError = error
        }
        
        viewModel.login(email: "admin@mintyn.com", password: "")
        XCTAssertEqual(receivedError, "Please enter your password.")
    }
    
    func testLogin_ValidInputs_TriggersSuccessBinding() {
        let expectation = XCTestExpectation(description: "Login Binding Success")
        
        viewModel.onSuccess = {
            expectation.fulfill()
        }
        
        viewModel.login(email: "admin@mintyn.com", password: "password123")
        wait(for: [expectation], timeout: 2.0)
    }
}
