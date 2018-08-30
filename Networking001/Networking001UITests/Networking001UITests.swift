//
//  Networking001UITests.swift
//  Networking001UITests
//
//  Created by Ankit Kumar Bharti on 28/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import XCTest

class Networking001UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testForSuccessfulLogin() {
       let usernameField = app.textFields.element(boundBy: 0)
        usernameField.tap()
        usernameField.typeText("abc@gmail.com")
        
        let passwordField = app.secureTextFields.element(boundBy: 0)
        passwordField.tap()
        passwordField.typeText("XYZABC")
        
        app.buttons["loginButton"].tap()
        
        let success = LoginMessage.success
        
        let alert = app.alerts.element(boundBy: 0)
        let alertTitle = alert.staticTexts.element(boundBy: 0).label
        XCTAssertTrue(alertTitle == success)
        
        alert.buttons["OK"].tap()
        
        let message = app.staticTexts["message"].label
        XCTAssertTrue(message == success)
    }
    
    func testForUnSuccessfulLoginAttempt0() {
        
        let username = "abc@gmail.com"
        let password = "ankit1"
        
        let usernameField = app.textFields.element(boundBy: 0)
        usernameField.tap()
        usernameField.typeText(username)
        
        let passwordField = app.secureTextFields.element(boundBy: 0)
        passwordField.tap()
        passwordField.typeText(password)
        
        app.buttons["loginButton"].tap()
        
        let failure = LoginMessage.wrongPassword + username
        
        let alert = app.alerts.element(boundBy: 0)
        let alertTitle = alert.staticTexts.element(boundBy: 0).label
        XCTAssertTrue(alertTitle == failure)
        
        alert.buttons["OK"].tap()
        
        let message = app.staticTexts["message"].label
        XCTAssertTrue(message == failure)
    }
    
    func testForUnSuccessfulLoginAttempt1() {
        app.buttons["loginButton"].tap()
        
        let failure = LoginMessage.emptyUsernameORPassword
        
        let alert = app.alerts.element(boundBy: 0)
        let alertTitle = alert.staticTexts.element(boundBy: 0).label
        XCTAssertTrue(alertTitle == failure)
        
        alert.buttons["OK"].tap()
        
        let message = app.staticTexts["message"].label
        XCTAssertTrue(message == failure)
    }
    
    func testForUnSuccessfulLoginAttempt2() {
        
        let username = "abcd@gmail.com"
        let password = "ankit1"
        
        let usernameField = app.textFields.element(boundBy: 0)
        usernameField.tap()
        usernameField.typeText(username)
        
        let passwordField = app.secureTextFields.element(boundBy: 0)
        passwordField.tap()
        passwordField.typeText(password)
        
        app.buttons["loginButton"].tap()
        
        let failure = LoginMessage.invalidUser + username
        
        let alert = app.alerts.element(boundBy: 0)
        let alertTitle = alert.staticTexts.element(boundBy: 0).label
        XCTAssertTrue(alertTitle == failure)
        
        alert.buttons["OK"].tap()
        
        let message = app.staticTexts["message"].label
        XCTAssertTrue(message == failure)
    }
}
