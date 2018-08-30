//
//  Utility.swift
//  Networking001
//
//  Created by Ankit Kumar Bharti on 29/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

class Utility {
    
    static func prepareRequest(data: Data, url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = data
        return urlRequest
    }
    
    static func decode(data: Data) throws -> LoginCredential {
        let decoder = JSONDecoder()
        return try decoder.decode(LoginCredential.self, from: data)
    }
    
    fileprivate static func userlist() throws -> [LoginCredential] {
        
        guard let fileURL = Bundle.main.url(forResource: "UserList", withExtension: "plist"), let data = try? Data(contentsOf: fileURL) else { throw  LoginError.FileNotFound }
        let plistDecoder = PropertyListDecoder()
        let users = try plistDecoder.decode([LoginCredential].self, from: data)
        return  users
    }
    
    static func isValidUser(by userCredential: LoginCredential, isTesting: Bool = false) throws -> Bool {
        let userList = try userlist()
        let filteredUser = userList.filter { return $0.username == userCredential.username }
        guard filteredUser.count > 0, let user = filteredUser.first else {
            if isTesting {
                return false
            }else {
                throw LoginError.UserNotFound(userCredential)
            }
        }
        guard user.password == userCredential.password else {
            if isTesting {
                return false
            }else {
                throw LoginError.InvalidPassword(userCredential)
            }
        }
        return true
    }
}


