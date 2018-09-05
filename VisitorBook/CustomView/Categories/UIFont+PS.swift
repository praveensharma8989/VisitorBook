//
//  UIFont+PS.swift
//  structureCoversionDemo
//
//  Created by praveen on 29/09/17.
//  Copyright © 2017 mobikasa. All rights reserved.
//

import Foundation
import UIKit
extension UIFont{
   public enum fontType: Int {
        case Regular = 0
        case Bold
        case SemiBold
        case Light
        case Rlight
        case Rmedium
        case Rregular
    }
    
//    typedef enum : NSUInteger {
//    Regular,
//    Bold,
//    Italic,
//    SemiBold,
//    Light,
//    Medium,
//    } fontType
    
   class func CA_AppFont(with type: fontType, size: CGFloat!) -> UIFont {
        var string: String =  AppConstants.K_THEME_FONT_REGULAR
        switch type {
        case fontType.Regular:
            string = AppConstants.K_THEME_FONT_REGULAR
            break
        case fontType.SemiBold:
            string = AppConstants.K_THEME_FONT_SEMIBOLD
            break
        case fontType.Bold:
            string = AppConstants.K_THEME_FONT_BOLD
            break
        case fontType.Rlight:
            string = AppConstants.K_THEME_FONT_LIGH
            break
        case fontType.Rmedium:
            string = AppConstants.K_THEME_FONT_MED
            break
        case fontType.Rregular:
            string = AppConstants.K_THEME_FONT_ROBOTOREG
            break
        default:
            string = AppConstants.K_THEME_FONT_LIGHT
            
        }
    return UIFont.init(name: string, size: size)! // (name: string, size: size )!
    }
}
