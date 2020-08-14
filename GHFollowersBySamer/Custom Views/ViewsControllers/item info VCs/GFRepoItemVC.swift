//
//  GFRepoItemVC.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/9/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .repos, count: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, count: user.publicGists)
        
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
        actionButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        view.layer.shadowColor = UIColor.systemPurple.cgColor
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
