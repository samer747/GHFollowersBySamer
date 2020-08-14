//
//  UIView+Ext.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/14/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

extension UIView{
    func addSubViews(_ Views: UIView...){
        for view in Views { self.addSubview(view) }
    }
}
