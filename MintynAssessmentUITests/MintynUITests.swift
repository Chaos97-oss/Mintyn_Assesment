import XCTest

final class MintynUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testLoginFlowUI() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Wait for Splash screen to transition to Login
        let welcomeText = app.staticTexts["Welcome"]
        XCTAssertTrue(welcomeText.waitForExistence(timeout: 5.0), "Login screen should appear after splash")
        
        // The mock logic takes any 8021234567 and password string
        // Since we decoupled standard textfield accessibility traits, we grab the raw input fields based on hierarchy or placeholders
        
        let phoneField = app.textFields["802 123 4567"]
        if phoneField.exists {
            phoneField.tap()
            phoneField.typeText("8021234567")
        }
        
        let passField = app.secureTextFields["********"]
        if passField.exists {
            passField.tap()
            passField.typeText("password")
            // Hide keyboard bounds logic is handled by standard tapping away or Login intercept
        }
        
        // Tap login
        let loginButton = app.buttons["Login"]
        XCTAssertTrue(loginButton.exists)
        loginButton.tap()
        
        // Wait for the Home screen to render by looking for the Home's specific title
        let homeText = app.staticTexts["Total Balance"]
        XCTAssertTrue(homeText.waitForExistence(timeout: 5.0), "Home dashboard should show after successful login")
    }
}
