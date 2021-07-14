//
//  UITestingDemoUITests.swift
//  UITestingDemoUITests
//
//  Created by Ryan Schefske on 7/13/21.
//

import XCTest

class UITestingDemoUITests: XCTestCase {
	
	let app = XCUIApplication()
	
	override func setUpWithError() throws {
		continueAfterFailure = false
		app.launch()
	}

	func testWelcome() throws {
		let welcome = app.staticTexts["Welcome!"]
		XCTAssert(welcome.exists)
	}
	
	func testLoginButton() throws {
		let login = app.buttons["loginButton"]
		XCTAssert(login.exists)
		XCTAssertEqual(login.label, "Login")
	}
	
	func testLoginFormAppearance() throws {
		app.buttons["loginButton"].tap()
		
		let loginNavigationBarTitle = app.staticTexts["Login"]
		XCTAssert(loginNavigationBarTitle.waitForExistence(timeout: 0.5))
	}
	
	func testLoginForm() throws {
		app.buttons["Login"].tap()
		
		let navigationBar = app.navigationBars.element
		XCTAssert(navigationBar.exists)
		
		let username = app.textFields["Username"]
		XCTAssert(username.exists)
		
		let password = app.secureTextFields["Password"]
		XCTAssert(password.exists)
		
		let login = app.buttons["loginNow"]
		XCTAssert(login.exists)
		XCTAssertEqual(login.label, "Login")
		
		let dismiss = app.buttons["Dismiss"]
		XCTAssert(dismiss.exists)
	}
	
	func testLoginDismiss() throws {
		app.buttons["Login"].tap()
		let dismiss = app.buttons["Dismiss"]
		dismiss.tap()
		XCTAssertFalse(dismiss.waitForExistence(timeout: 0.5))
	}
	
	func testUsername() throws {
		app.buttons["Login"].tap()
		
		let username = app.textFields["Username"]
		username.tap()
		username.typeText("test")
		
		XCTAssertNotEqual(username.value as! String, "")
	}
	
	func testPassword() throws {
		app.buttons["Login"].tap()
		
		app.secureTextFields.element.tap()
		app.keys["p"].tap()
		app.keys["a"].tap()
		app.keys["s"].tap()
		app.keys["s"].tap()
		app.keyboards.buttons["Return"].tap()
		
		XCTAssertNotEqual(app.secureTextFields.element.value as! String, "")
	}
	
	func testLogin() throws {
		app.buttons["Login"].tap()
		
		app.textFields.element.tap()
		app.textFields.element.typeText("test")
		
		app.secureTextFields.element.tap()
		app.secureTextFields.element.typeText("pass")
		app.keyboards.buttons["Return"].tap()
		
		let loginButton = app.buttons["loginNow"]
		loginButton.tap()
		
		XCTAssertFalse(loginButton.waitForExistence(timeout: 0.5))
	}
	
	func testFailedLoginAlert() throws {
		app.buttons["Login"].tap()
		app.buttons["loginNow"].tap()
		
		XCTAssert(app.alerts.element.waitForExistence(timeout: 0.5))
		
		app.alerts.element.buttons["OK"].tap()
		XCTAssertFalse(app.alerts.element.exists)
	}
	
	func testWelcomeAfterLogin() throws {
		XCTAssert(app.staticTexts["Welcome!"].exists)
		
		try login()
		
		XCTAssert(app.staticTexts["Welcome, test!"].exists)
	}
	
	func testLoginLogoutLabel() throws {
		XCTAssertEqual(app.buttons["loginButton"].label, "Login")
		
		try login()
		
		XCTAssertEqual(app.buttons["loginButton"].label, "Logout")
	}
	
	func testLogout() throws {
		try login()
		
		XCTAssert(app.staticTexts["Welcome, test!"].exists)
		XCTAssertEqual(app.buttons["loginButton"].label, "Logout")
		
		app.buttons["loginButton"].tap()
		
		XCTAssert(app.staticTexts["Welcome!"].exists)
		XCTAssertEqual(app.buttons["loginButton"].label, "Login")
	}
}

extension UITestingDemoUITests {
	func login() throws {
		app.buttons["Login"].tap()
		
		app.textFields.element.tap()
		app.textFields.element.typeText("test")
		
		app.secureTextFields.element.tap()
		app.secureTextFields.element.typeText("pass")
		app.keyboards.buttons["Return"].tap()
		
		app.buttons["loginNow"].tap()
	}
}
