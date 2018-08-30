//
//  LoginCredential.swift
//  Networking001
//
//  Created by Ankit Kumar Bharti on 28/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation


struct LoginCredential: Codable, Equatable {
    let username: String
    let password: String
}


extension LoginCredential {
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
}
