//
//  GFTitleLable.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/5/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) { // convenience de btnady 3al init ely foo2 da fa msh lazm tktb el code marten
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    
    private func configure() {
        textColor                   = .label
        adjustsFontSizeToFitWidth   = true //lma el text yzeed 3n el width ... el size bta3 el text hys8r
        minimumScaleFactor          = 0.9 //hys8r be el scale de
        lineBreakMode               = .byTruncatingTail //lma el el scaly ywsl a5ro ( 0.9 ) hy3ml fe a5r el klam ... w y5fy el ba2y
        translatesAutoresizingMaskIntoConstraints = false
    }
}
