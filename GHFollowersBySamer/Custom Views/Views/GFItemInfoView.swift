//
//  GFItemInfoView.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/9/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case repos , gists , following , followers
}

class GFItemInfoView: UIView {

    let symbolImageView = UIImageView()
    let titleLable      = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLable      = GFTitleLabel(textAlignment: .center, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
         configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubViews(symbolImageView,titleLable,countLable)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLable.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLable.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLable.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLable.heightAnchor.constraint(equalToConstant: 18),
            
            countLable.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLable.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLable.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLable.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemInfoType: ItemInfoType,count: Int) {
        switch itemInfoType {
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLable.text = "Followers"
            break
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLable.text = "Following"
            break
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLable.text = "Public Gists"
            break
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLable.text = "Public Repos"
            break
        }
        countLable.text = "\(count)"
    }
    
}
