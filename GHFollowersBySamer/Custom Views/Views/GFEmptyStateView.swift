//
//  GFEmptyStateView.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/8/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {

    let messageLable = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLable.text = message
    }
    
    
    private func configure(){
        addSubViews(messageLable,logoImageView)
        configureMessageLable()
        configureLogoImageView()
    }
    
    private func configureMessageLable(){
        messageLable.numberOfLines = 3
        messageLable.textColor     = .secondaryLabel
        messageLable.translatesAutoresizingMaskIntoConstraints = false
        
        let seAnd8PaddingCenter:CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed || DeviceTypes.isiPhone8Standard ? -90 : -150
        
        
        NSLayoutConstraint.activate([
            messageLable.centerYAnchor.constraint(equalTo: centerYAnchor, constant: seAnd8PaddingCenter),
            messageLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLable.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    private func configureLogoImageView(){
        logoImageView.image = Images.emptyStateImage
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let seAnd8PaddingBottom:CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed || DeviceTypes.isiPhone8Standard ? 80 : 40
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: seAnd8PaddingBottom)
        ])
    }
}
