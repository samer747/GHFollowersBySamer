//
//  UIViewController+Ext.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/5/20.
//  Copyright © 2020 samer. All rights reserved.
//


import UIKit
import SafariServices



extension UIViewController {
    
    
    // Present Alert view in any UiViewController
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafri(with url: URL) {
        let safriVC = SFSafariViewController(url: url)
        safriVC.preferredControlTintColor = .systemGreen
        present(safriVC, animated: true)
    }
    

    
}
 
