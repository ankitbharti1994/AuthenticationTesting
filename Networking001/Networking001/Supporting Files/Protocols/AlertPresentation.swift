//
//  AlertPresentation.swift
//  Networking001
//
//  Created by Ankit Kumar Bharti on 30/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import UIKit

protocol AlertPresentation {
    func presentAlert(title: String?, message: String?)
}

extension AlertPresentation where Self: UIViewController {
    func presentAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            alertController.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
