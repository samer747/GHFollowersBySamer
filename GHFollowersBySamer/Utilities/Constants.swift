//
//  Constants.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/9/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit


enum SFSymbols {
    static let location   = UIImage(systemName: "mappin.and.ellipse")
    static let repos      = UIImage(systemName: "folder")
    static let gists      = UIImage(systemName: "text.alignleft")
    static let following  = UIImage(systemName: "heart")
    static let followers  = UIImage(systemName: "person.2")
}

enum Images {
    static let ghLogo = UIImage(named: "gh-logo")
    static let emptyStateImage = UIImage(named: "empty-state-logo")
    static let gfAvatarLogo = UIImage(named: "avatar-placeholder")
}


enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale
   
    
    //Devices
    static let isiPhoneSE              = idiom == .phone && ScreenSize.maxLength == 568.0 // Old SE and iphone 5
    
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale // New Se and 8 7 6
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale  > scale
    
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale == scale
    
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength  == 896.0
    
    static let isiPad                   = idiom == .phone && ScreenSize.maxLength >= 1024.0
    
    static func isIPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
