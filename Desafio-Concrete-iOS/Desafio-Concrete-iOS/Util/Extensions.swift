//
//  Extensions.swift
//  Desafio-Concrete-iOS
//
//  Created by Everton Carneiro on 17/01/18.
//  Copyright © 2018 Everton. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func createAlert(withTitle title: String, message: String, actionTitle: String ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func createAlertWithDismiss(withTitle title: String, message: String, actionTitle: String ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func addActivityIndicator(_ activityIndicator: UIActivityIndicatorView) {
        
        activityIndicator.backgroundColor = UIColor(red:0.10, green:0.10, blue:0.10, alpha:0.5)
        activityIndicator.layer.cornerRadius = 8
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        
    }
 
}



