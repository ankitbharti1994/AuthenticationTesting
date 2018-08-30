//
//  Extension.swift
//  Networking001
//
//  Created by Ankit Kumar Bharti on 30/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

public let passwordValidationMessage = "the length of password should be of 8 to 15 character. first character should be captial 'A' to 'Z' then there should be 1 or more small character from 'a' to 'z' then one special case character (@, _, &, ~) and in the end 1 or more numeric character. for example:- Xabc@1234"

extension String {
    
    /// the length of password should be of 8 to 15 character. first character should be captial 'A' to 'Z' then there should be 1 or more small character from 'a' to 'z' then one special case character (@, _, &, ~) and in the end 1 or more numeric character. for example:- Xabc@1234
    var isValidPassword: Bool {
        let pattern = "^[A-Z][[a-z]+[\\W][0-9]+]{7,14}$"
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let results = regex.firstMatch(in: self, options: .reportCompletion, range: NSRange(location: 0, length: self.count))
            return results != nil
        } catch {
            return false
        }
    }
}
