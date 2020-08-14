//
//  GFAvatarImageView.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/7/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = Images.gfAvatarLogo
    let cache = NetworkManager.shared.cache //local cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
