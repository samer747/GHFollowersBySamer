//
//  SearchVc.swift
//  GHFollowersBySamer
//
//  Created by samer on 7/27/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    //MARK: ----------- Variables ---------------
    let logoImageView = UIImageView()
    let userNameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    var isUsernameEntered: Bool{
        return !userNameTextField.text!.isEmpty
    }
    
    //MARK: ----------- ViewDidLoad ---------------
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureUserNameTextField()
        configureCallToActionButton()
        creatDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    //MARK: ----------- Methods ---------------
    func creatDismissKeyboardTapGesture()  {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFolloweListVC()
    {
        guard isUsernameEntered else {
            self.presentGFAlertOnMainThread(title: "Empty Username", message: "we need a user need please", buttonTitle: "ok")
            return

        }

      let followerListVC = FollowerListVC()
        followerListVC.username = self.userNameTextField.text
        followerListVC.title = self.userNameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    //MARK: ----------- Confige ---------------
    private func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    private func configureUserNameTextField(){
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    private func  configureCallToActionButton(){
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFolloweListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
             callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
             callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
             callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
}

extension SearchVC: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFolloweListVC()
        return true
    }
}
