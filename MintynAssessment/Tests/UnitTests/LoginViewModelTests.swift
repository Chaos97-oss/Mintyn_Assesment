import XCTest
@testable import MintynAssessment

final class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoginEmptyPhoneNumber() {
        let expectation = self.expectation(description: "Wait for error")
        viewModel.onError = { message in
            XCTAssertEqual(message, "Please enter your phone number.")
            expectation.fulfill()
        }
        
        viewModel.login(phoneNumber: "", password: "password")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testLoginEmptyPassword() {
        let expectation = self.expectation(description: "Wait for error")
        viewModel.onError = { message in
            XCTAssertEqual(message, "Please enter your password.")
            expectation.fulfill()
        }
        
        viewModel.login(phoneNumber: "8021234567", password: "")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testLoginStateChanges() {
        let expectationStart = self.expectation(description: "Loading starts")
        let expectationStop = self.expectation(description: "Loading stops")
        
        var loadingStates: [Bool] = []
        
        viewModel.onLoadingStateChanged = { isLoading in
            loadingStates.append(isLoading)
            if isLoading {
                expectationStart.fulfill()
            } else {
                expectationStop.fulfill()
            }
        }
        
        viewModel.login(phoneNumber: "8021234567", password: "password")
        
        waitForExpectations(timeout: 2.0, handler: nil)
        
        // Ensure state goes [true, false]
        XCTAssertEqual(loadingStates.count, 2)
        XCTAssertTrue(loadingStates[0])
        XCTAssertFalse(loadingStates[1])
    }
}
