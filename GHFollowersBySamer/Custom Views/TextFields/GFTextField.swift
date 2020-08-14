//
//  GFTextField.swift
//  GHFollowersBySamer
//
//  Created by samer on 7/27/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    
    configure()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure()
    {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = 2
        
        textColor = .label //lable da abyd aw eswed depending on dark or light mode
        tintColor = .label // loon el curser
        font = UIFont.preferredFont(forTextStyle: .title2) //dynamic depending on users system font choice
        textAlignment = .center
        adjustsFontSizeToFitWidth = true //34an lw el user ktb kter el font yfdl ys8r kda 34an yb2a fit lel field
        minimumFontSize = 12 //34an el font myys8r4 awy
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        autocapitalizationType = .none
        returnKeyType = .go
        clearButtonMode = .whileEditing
        placeholder = "Enter a username"
    }
    
}
