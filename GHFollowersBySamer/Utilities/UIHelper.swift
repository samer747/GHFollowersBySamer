//
//  UIHelper.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/7/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

enum UIHelper { //el enum mn2dr4 n3ml mno object el struct momken
    
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding) //el insits bta3t el cells kolha msh kol cel lwa7daha
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40) //size for Cell
        
        return flowLayout
    }
}
