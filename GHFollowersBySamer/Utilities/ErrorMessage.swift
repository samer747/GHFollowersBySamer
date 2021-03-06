//
//  ErrorMessage.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/7/20.
//  Copyright © 2020 samer. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFollow     = "Error in following this profile, Please try again"
    case alreadyInFavorites = "This user is already in your Favorite"
}
