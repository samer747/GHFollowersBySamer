//
//  UITableView+Ext.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/14/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

extension UITableView{
    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }

}
