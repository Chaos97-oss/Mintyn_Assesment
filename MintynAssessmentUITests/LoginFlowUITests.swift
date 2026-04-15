import XCTest

class LoginFlowUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testLoginAndNavigateToHome_ThenLogout() throws {
        // Wait for Splash screen to transition to Login (approx 3 seconds)
        let loginButton = app.buttons["Login"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: 5.0), "Login button should appear after splash")
        
        // Find text fields
        let emailField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]
        
        XCTAssertTrue(emailField.exists)
        XCTAssertTrue(passwordField.exists)
        
        // Enter credentials
        emailField.tap()
        emailField.typeText("admin@mintyn.com")
        
        passwordField.tap()
        passwordField.typeText("password123")
        
        // Tap login
        loginButton.tap()
        
        // Wait for MockAuthService delay (1.5s) and transition
        let homeWelcomeLabel = app.staticTexts["Good Morning, User"]
        XCTAssertTrue(homeWelcomeLabel.waitForExistence(timeout: 4.0), "Home screen should appear after successful login")
        
        // Navigation to Settings
        // We set the profile button to use the "person.crop.circle.fill" system image, but we can access it using its accessibility feature if needed, or by tapping navigation bar item.
        let profileBtn = app.buttons["person.crop.circle.fill"]
        if profileBtn.exists {
            profileBtn.tap()
        } else {
            // Find by typical button index or coordinate if needed in a more robust test
            app.buttons.firstMatch.tap()
        }
        
        // Verify we are in Settings
        XCTAssertTrue(app.navigationBars["Settings"].waitForExistence(timeout: 2.0))
        
        // Logout flow
        let logoutCell = app.cells.staticTexts["Log out"]
        XCTAssertTrue(logoutCell.exists)
        logoutCell.tap()
        
        // Handle Alert
        let alertLogoutButton = app.alerts["Log out"].buttons["Log out"]
        XCTAssertTrue(alertLogoutButton.waitForExistence(timeout: 2.0))
        alertLogoutButton.tap()
        
        // Verify Back to Login
        XCTAssertTrue(loginButton.waitForExistence(timeout: 3.0), "Should revert to login screen after logout")
    }
}
