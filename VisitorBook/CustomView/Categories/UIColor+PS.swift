//
//  UIColor+PS.swift
//  ChachisHomemadeFood
//
//  Created by praveen on 10/27/17.
//  Copyright © 2017 Mac-9. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    
    

    static let APPTHEMECOLOR : UIColor = {
        
        return UIColor(red: 236.0/255.0, green: 70.0/255.0, blue: 64.0/255.0, alpha: 1.0)
    }()
    
    static let GRADIENTTOMATO : UIColor = {
        
        return UIColor(red: 236.0/255.0, green: 70.0/255.0, blue: 64.0/255.0, alpha: 1.0)
    }()
    
    static let GRADIENTDULLRED : UIColor = {
        
        return UIColor(red : 174.0/255.0, green : 67.0/255.0, blue : 63.0/255.0, alpha: 1.0)
        
    }()
    
    static let ATTRIBUTETEXTCOLOR : UIColor = {
        
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }()
    
    static let TOPALERTCOLOR : UIColor = {
        
        return UIColor(red: 204.0/255.0, green: 47.0/255.0, blue: 31.0/255.0, alpha: 1.0)
    }()
    
    static let DEFAULTGRAY : UIColor = {
        
        return UIColor(red: 199.0/255.0, green: 199.0/255.0, blue: 205.0/255.0, alpha: 1.0)
    }()
    
    static let LOC_COLOR : UIColor = {
        
        return UIColor(red:64.0/255.0 , green: 64.0/255.0, blue: 64.0/255.0, alpha: 1.0)
    }()
    
    static let DEFAULTGRAY_DARK : UIColor = {
        
        return UIColor(red: 129.0/255.0, green: 129.0/255.0, blue: 129.0/255.0, alpha: 1.0)
    }()
    static let DEFAULTGRAY_LIGHT : UIColor = {
        
        return UIColor(red: 114.0/255.0, green: 114.0/255.0, blue: 114.0/255.0, alpha: 1.0)
    }()
    
    static func getUIColorFromHex(hexString:String) -> UIColor?
    {
            if hexString.hasPrefix("#") {
                let start = hexString.index(hexString.startIndex, offsetBy: 1)
                let hexColor = String(hexString[start...])
                
                if hexColor.count == 6 {
                    let scanner = Scanner(string: hexColor.lowercased())
                    var hexNumber: UInt64 = 0
                    
                    if scanner.scanHexInt64(&hexNumber) {
                        let r = CGFloat((hexNumber & 0xff0000) >> 16)
                        let g = CGFloat((hexNumber & 0xff00) >> 8)
                        let b = CGFloat(hexNumber & 0xff)
                        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
                    }
                }
            }
            return nil
    }
    
   static func getColorFromAlphabet(_ alphabet : String) -> UIColor {
    
//    let Asciicode : UInt32 = (alphabet.unicodeScalars.filter{$0.isASCII}.first?.value)!
//    let multipliewvalue = Asciicode * (Asciicode / 2)
//    return UIColor(red: CGFloat(multipliewvalue+20)/255.0 , green:CGFloat(Asciicode+40)/255.0 , blue: CGFloat(Asciicode+60)/255.0, alpha: 1.0)
    
        switch (alphabet) {
        case "A":
           // return UIColor(red: 252.0/255.0, green: 92.0/255.0, blue: 101.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#fc5c65") ?? UIColor.white
        case "B":
            //return UIColor(red: 253.0/255.0, green: 150.0/255.0, blue: 68.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#fd9644") ?? UIColor.white
        case "C":
            //return UIColor(red: 165.0/255.0, green: 94.0/255.0, blue: 234.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#a55eea") ?? UIColor.white
        case "D":
            //return UIColor(red: 43.0/255.0, green: 203.0/255.0, blue: 156.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#2bcbba") ?? UIColor.white
        case "E":
            //return UIColor(red: 207.0/255.0, green: 216.0/255.0, blue: 220.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#CFD8DC") ?? UIColor.white
        case "F":
            //return UIColor(red: 119.0/255.0, green: 140.0/255.0, blue: 163.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#778ca3") ?? UIColor.white
        case "G":
            //return UIColor(red: 69.0/255.0, green: 170.0/255.0, blue: 242.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#45aaf2") ?? UIColor.white
        case "H":
            //return UIColor(red: 204.0/255.0, green: 82.0/255.0, blue: 122.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#CC527A") ?? UIColor.white
        case "I":
            //return UIColor(red: 54.0/255.0, green: 54.0/255.0, blue: 54.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#363636") ?? UIColor.white
        case "J":
            //return UIColor(red: 47.0/255.0, green: 149.0/255.0, blue: 153.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#2F9599") ?? UIColor.white
        case "K":
            //return UIColor(red: 125.0/255.0, green: 78.0/255.0, blue: 80.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#FF4E50") ?? UIColor.white
        case "L":
            //return UIColor(red: 69.0/255.0, green: 173.0/255.0, blue: 168.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#45ADA8") ?? UIColor.white
        case "M":
            //return UIColor(red: 167.0/255.0, green: 134.0/255.0, blue: 110.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#A7226E") ?? UIColor.white
        case "N":
            //return UIColor(red: 136.0/255.0, green: 132.0/255.0, blue: 73.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#EC2049") ?? UIColor.white
        case "O":
                //return UIColor(red: 142.0/255.0, green: 107.0/255.0, blue: 56.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#F26B38") ?? UIColor.white
        case "P":
            //return UIColor(red: 247.0/255.0, green: 219.0/255.0, blue: 79.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#F7DB4F") ?? UIColor.white
        case "Q":
            //return UIColor(red: 47.0/255.0, green: 149.0/255.0, blue: 153.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#2F9599") ?? UIColor.white
        case "R":
            //return UIColor(red: 153.0/255.0, green: 184.0/255.0, blue: 152.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#99B898") ?? UIColor.white
        case "S":
            //return UIColor(red: 255.0/255.0, green: 132.0/255.0, blue: 124.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#FF847C") ?? UIColor.white
        case "T":
            //return UIColor(red: 42.0/255.0, green: 183.0/255.0, blue: 202.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#2ab7ca") ?? UIColor.white
        case "U":
            //return UIColor(red: 254.0/255.0, green: 215.0/255.0, blue: 102/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#fed766") ?? UIColor.white
        case "V":
            //return UIColor(red: 1.0/255.0, green: 31.0/255.0, blue: 75/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#011f4b") ?? UIColor.white
        case "W":
            //return UIColor(red: 133.0/255.0, green: 30.0/255.0, blue: 62.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#851e3e") ?? UIColor.white
        case "X":
            //return UIColor(red: 254.0/255.0, green: 156.0/255.0, blue: 143.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#fe9c8f") ?? UIColor.white
        case "Y":
            //return UIColor(red: 84.0/255.0, green: 178.0/255.0, blue: 169/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#54b2a9") ?? UIColor.white
        case "Z":
            //return UIColor(red: 75.0/255.0, green: 56.0/255.0, blue: 50.0/255.0, alpha: 1.0)
            return getUIColorFromHex(hexString: "#4b3832") ?? UIColor.white
      
        default:
           return UIColor(red: 78.0/255.0, green: 52.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        }
    
    }
}
