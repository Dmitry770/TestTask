//
//  UIVIewController.swift
//  TestTask
//
//  Created by Macintosh on 20/12/2019.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?, _ handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(buttonOk)
        present(alert, animated: true)
    }
    
}
