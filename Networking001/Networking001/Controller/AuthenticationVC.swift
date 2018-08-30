//
//  ViewController.swift
//  Networking001
//
//  Created by Ankit Kumar Bharti on 28/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

class AuthenticationVC: UIViewController, AlertPresentation {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBAction func login(_ sender: Any) {
        guard let username = usernameField.text, let password = passwordField.text, username.count > 0, password.count > 0 else {
            messageLabel.text = LoginMessage.emptyUsernameORPassword
            presentAlert(title: nil, message: LoginMessage.emptyUsernameORPassword)
            return
        }
        
        AuthenticationManager.authenticate(username: username, password: password) {[weak self] message in
            DispatchQueue.main.async {
                self?.messageLabel.text = message
                self?.presentAlert(title: nil, message: message)
            }
        }
    }
}

