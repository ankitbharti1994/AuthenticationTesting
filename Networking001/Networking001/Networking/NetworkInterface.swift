//
//  NetworkInterface.swift
//  Networking001
//
//  Created by Ankit Kumar Bharti on 28/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

enum LoginError: Error {
    case InvalidPassword(LoginCredential)
    case UserNotFound(LoginCredential)
    case FileNotFound
}

typealias NetworkHandler = (Result<Data, LoginError>) -> ()

class NetworkInterface {
    
    private(set) var request: URLRequest
    private var session: URLSession
    
    init(request: URLRequest, session: URLSession) {
        self.request = request
        self.session = session
    }
    
    func authenticate(handler: @escaping NetworkHandler) {
        session.dataTask(with: request) { (data, response, error) in
            guard let loginError = error as? LoginError else {
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.isValidResponse else {
                    handler(.Failure(.FileNotFound))
                    return
                }
                guard let responseData = data else {
                    handler(.Failure(LoginError.FileNotFound))
                    return
                }
                handler(.Success(responseData, self.request, response!))
                return
            }
            handler(.Failure(loginError))
        }.resume()
    }
}

public extension URLResponse {
    public var isValidResponse: Bool {
        let statusCode = (self as! HTTPURLResponse).statusCode
        return (200...300).contains(statusCode)
    }
}




