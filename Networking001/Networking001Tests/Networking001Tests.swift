//
//  Networking001Tests.swift
//  Networking001Tests
//
//  Created by Ankit Kumar Bharti on 28/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import XCTest
@testable import Networking001

class Networking001Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        URLProtocol.registerClass(MockURLProtocol.self)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test cases for valid user
    func testForValidUser() throws {
        let loginCredential = LoginCredential(username: "abc@gmail.com", password: "XYZABC")
        let isValid = try Utility.isValidUser(by: loginCredential, isTesting: true)
        XCTAssertTrue(isValid)
    }
    
    func testForInvalidUser() throws {
        let loginCredential = LoginCredential(username: "rohit", password: "ankit")
        let isValid = try Utility.isValidUser(by: loginCredential, isTesting: true)
        XCTAssertFalse(isValid)
    }
    
    func testForInvalidPassword() throws {
        let loginCredential = LoginCredential(username: "abc@gmail.com", password: "ankit1")
        let isValid = try Utility.isValidUser(by: loginCredential, isTesting: true)
        XCTAssertFalse(isValid)
    }
    
    func testForRequest() throws  {
       
        let url = URL(string: "https://google.co.in")
        
        let loginCredential = LoginCredential(username: "ankit123", password: "ankit123")
        
        let data = try loginCredential.encode()
        
        let request = Utility.prepareRequest(data: data, url: url!)
        XCTAssertEqual(request.url?.scheme, "https")
        XCTAssertEqual(request.url?.host, "google.co.in")
        XCTAssertNotNil(request.httpBody)
        
        let requestData = request.httpBody!
        let requestLoginCredential = try Utility.decode(data: requestData)
        XCTAssertEqual(loginCredential, requestLoginCredential)
    }
    
    
    func testForNetworkRequest() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        let loginCredential = LoginCredential(username: "abc@gmail.com", password: "XYZABC")
        
        let mockData = try loginCredential.encode()
        
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url?.host, "google.co.in")
            let response = HTTPURLResponse(url: URL(string: "https://google.co.in")!, statusCode: 200, httpVersion: nil, headerFields: nil)
            let isValidUser = try Utility.isValidUser(by: loginCredential, isTesting: true)
            return (response!, isValidUser ? mockData : Data(), nil)
        }
        
        let session = URLSession(configuration: config)
        
        var request = URLRequest(url: URL(string: "https://google.co.in")!)
        request.timeoutInterval = 10
        
        let networkingRequest = NetworkInterface(request: request, session: session)
        
        let networkExpectation = expectation(description: "networking expectation")
        
        networkingRequest.authenticate { result in
            switch result {
            case .Failure(let error):
                XCTFail("\(error)")
            case .Success(let data, _, _):
                XCTAssertGreaterThan(data.count, 0)
            }
            networkExpectation.fulfill()
        }
        
        wait(for: [networkExpectation], timeout: 1)
        
    }
    
    // MARK: - Test cases for password validation
    func testForValidPassword() {
        XCTAssertTrue("Xyz@1233".isValidPassword, passwordValidationMessage)
    }
    
    func testForValidPassword1() {
        XCTAssertTrue("Xyz@12332345678".isValidPassword, passwordValidationMessage)
    }
    
    func testForInvalidPassword0() {
        XCTAssertFalse("XXyz@123".isValidPassword, passwordValidationMessage)
    }
    
    func testForInvalidPassword1()  {
        XCTAssertFalse("XXyz@12".isValidPassword, passwordValidationMessage)
    }
    
    func testForInvalidPassword2()  {
        XCTAssertFalse("XXyz1234".isValidPassword, passwordValidationMessage)
    }
    
    func testForInvalidPassword3()  {
        XCTAssertFalse("XXyz@12343456678".isValidPassword, passwordValidationMessage)
    }
    
    func testForInvalidPassword4()  {
        XCTAssertFalse("XYyz1234".isValidPassword, passwordValidationMessage)
    }
}
