//
//  Follower.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/6/20.
//  Copyright © 2020 samer. All rights reserved.
//

import Foundation

struct Follower: Codable ,Hashable{ //hashable 34an el  DiffableDataSource
    var login: String
    var avatarUrl: String
}
