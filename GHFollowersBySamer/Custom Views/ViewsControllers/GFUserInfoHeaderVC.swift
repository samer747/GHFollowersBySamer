//
//  GFUserInfoHeaderVC.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/9/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    let avatarImageView         = GFAvatarImageView(frame: .zero)
    let usernameLable           = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLable               = GFSecondaryTitleLable(fontSize: 18)
    let locationImageView       = UIImageView()
    let locationLable           = GFSecondaryTitleLable(fontSize: 18)
    let bioLable                = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubViews(avatarImageView,usernameLable,nameLable,locationImageView,locationLable,bioLable)
        layoutUI()
        configureUIElements()
    }
    

    private func configureUIElements(){
        
        downloadImage()
        usernameLable.text     = user.login
        nameLable.text         = user.name ?? ""
        locationLable.text     = user.location ?? "No Location"
        bioLable.text          = user.bio ?? "Empty Bio"
        bioLable.numberOfLines = 3

        locationImageView.image = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
    }
    
    fileprivate func downloadImage() {
        NetworkManager.shared.downloadImage(from: user.avatarUrl) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }

    
    private func layoutUI(){
        let padding: CGFloat         = 20
        let textImagePading: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Avatar Image View
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            
            // UserName Lable
            usernameLable.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePading),
            usernameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLable.heightAnchor.constraint(equalToConstant: 28),
            
            // Name Lable
            nameLable.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePading),
            nameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLable.heightAnchor.constraint(equalToConstant: 20),
            
            // Location ImageView
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePading),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            
            // Location Lable
            locationLable.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLable.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLable.heightAnchor.constraint(equalToConstant: 20),
            
            // Bio Lable
            bioLable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 0),
            bioLable.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLable.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    

}
   
