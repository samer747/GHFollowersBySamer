//
//  GFFollowItemVC.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/10/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class GFFollowItemVC: GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .followers, count: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, count: user.following)
        
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
        actionButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        view.layer.shadowColor = UIColor.systemGreen.cgColor
    }
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
