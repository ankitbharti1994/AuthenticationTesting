//
//  AuthenticationManager.swift
//  Networking001
//
//  Created by Ankit Kumar Bharti on 30/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

struct AuthenticationManager {
    
    static func authenticate(username: String, password: String, _ handler: @escaping (String) -> ()) {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        let loginCredential = LoginCredential(username: username, password: password)
        
        let mockData = try! loginCredential.encode()
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "https://google.co.in")!, statusCode: 200, httpVersion: nil, headerFields: nil)
            do {
                let isValidUser = try Utility.isValidUser(by: loginCredential)
                return (response!, isValidUser ? mockData : Data(), nil)
            } catch LoginError.UserNotFound(let credential) {
                return (response!, nil, LoginError.UserNotFound(credential))
            } catch LoginError.InvalidPassword(let credential) {
                return (response!, nil, LoginError.InvalidPassword(credential))
            }catch {
                return (response!, nil, LoginError.FileNotFound)
            }
        }
        
        let session = URLSession(configuration: config)
        
        var request = URLRequest(url: URL(string: "https://google.co.in")!)
        request.timeoutInterval = 10
        
        let networkingRequest = NetworkInterface(request: request, session: session)
        
        networkingRequest.authenticate { result in
            let message: String
            switch result {
            case .Failure( let error):
                message = AuthenticationManager.handleError(error: error)
            case .Success(let data, _, _):
                message = data.count > 0 ? LoginMessage.success : LoginMessage.failure
            }
            handler(message)
        }
    }
    
    private static func handleError(error: Error) -> String {
        guard let error = error as? LoginError else {
            return "Unknown error"
        }
        switch error {
        case .InvalidPassword(let credential):
            return LoginMessage.wrongPassword + credential.username
        case .UserNotFound(let credential):
            return LoginMessage.invalidUser + credential.username
        case .FileNotFound:
            return "File Not found"
        }
    }
}
