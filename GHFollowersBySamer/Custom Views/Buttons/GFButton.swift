//
//  GfButton.swift
//  GHFollowersBySamer
//
//  Created by samer on 7/27/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        setTitleColor(.white, for: .normal)
        layer.cornerRadius      = 10
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline) //byb2a dynamic m3 el 7gm el system font ely el user me5taro
        translatesAutoresizingMaskIntoConstraints = false
    }

    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        
    }
}
