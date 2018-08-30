//
//  Enumeration.swift
//  Networking001
//
//  Created by Ankit Kumar Bharti on 30/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

enum LoginMessage {
    static let success = "Successful"
    static let failure = "UnSuccessful"
    static let invalidUser = "invalid user : "
    static let emptyUsernameORPassword = "Please enter username and password"
    static let wrongPassword = "wrong password entered for user : "
}

enum Result<data, error> {
    case Success(data, URLRequest, URLResponse)
    case Failure(error)
}

enum NetworkingError: Error {
    case InvalidURL
    case NetworkError
    case FileNotFound
    case DataNotFound
}
