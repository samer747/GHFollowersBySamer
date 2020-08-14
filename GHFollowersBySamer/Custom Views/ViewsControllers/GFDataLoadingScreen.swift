//
//  GFDataLoadingScreen.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/13/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class GFDataLoadingScreen: UIViewController {

    var containerView : UIView!
    
    
    // Present indecator view in any UiViewController
    func showIndecatorView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.40) { self.containerView.alpha = 0.8 }
        
        let activityIndecator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndecator)
        
        activityIndecator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndecator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndecator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndecator.startAnimating()
        
    }
    func dismissIndecatorView() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, animations: { self.containerView.alpha = 0 }) { (_) in
                self.containerView.removeFromSuperview()
                self.containerView = nil
            }
        }
    }
    
    func showEmptyStateView(message: String, view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        
        view.addSubview(emptyStateView)
    }

}
