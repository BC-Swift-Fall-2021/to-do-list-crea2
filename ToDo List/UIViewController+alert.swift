//
//  UIViewController+alert.swift
//  ToDo List
//
//  Created by Christopher Rea on 10/4/21.
//

import UIKit

extension UIViewController{
    func oneButtonAlert(Title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil )
    }
}
