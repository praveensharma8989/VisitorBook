//
//  UIImage+PS.swift
//  ChachisHomemadeFood
//
//  Created by praveen on 10/24/17.
//  Copyright © 2017 Mac-9. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func set_sdWebImage(With URLstring : String ,placeHolderImage: String)  {
        self.sd_setShowActivityIndicatorView(true)
        self.sd_setIndicatorStyle(UIActivityIndicatorViewStyle.gray )
        
     //   let imageurl = URLstring.replacingOccurrences(of:" ", with:"")
        let strUrl = URLstring.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        self.sd_setImage(with: (NSURL.init(string: strUrl)! as URL), placeholderImage: UIImage(named:placeHolderImage) , options: SDWebImageOptions.refreshCached) { (image, errorr, type, url) in
            
            if(errorr == nil){
                
                if type == SDImageCacheType.none || type == SDImageCacheType.disk{
                    UIView.transition(with: self, duration: 1.0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                        self.image = nil
                        self.image = image
                        
                    }, completion:nil)
                }
                   else
                    {
                        self.backgroundColor = UIColor.groupTableViewBackground
                    }
                    }else
                    {
                        
                    }
                  }
              }
    func set_sdWebImage(With URLstring : String ,placeHolderImage: String , backgroundColor:UIColor )  {
        self.sd_setShowActivityIndicatorView(true)
        self.sd_setIndicatorStyle(UIActivityIndicatorViewStyle.gray )
        
        //   let imageurl = URLstring.replacingOccurrences(of:" ", with:"")
        let strUrl = URLstring.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        self.sd_setImage(with: (NSURL.init(string: strUrl)! as URL), placeholderImage: UIImage(named:placeHolderImage) , options: SDWebImageOptions.allowInvalidSSLCertificates) { (image, errorr, type, url) in
            
            if(errorr == nil){
                
                if type == SDImageCacheType.none || type == SDImageCacheType.disk{
                    UIView.transition(with: self, duration: 1.0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                        self.image = nil
                        self.image = image
                        
                    }, completion:nil)
                }
                else
                {
                    self.backgroundColor = backgroundColor
                }
            }else
            {
                
            }
        }
    }
    
    func set_sdWebImage(With URLstring : String ,placeHolderImage: UIImage ,withFailCompletion : @escaping (Bool)->Void)  {
        self.sd_setShowActivityIndicatorView(true)
        self.sd_setIndicatorStyle(UIActivityIndicatorViewStyle.gray )
        
        //   let imageurl = URLstring.replacingOccurrences(of:" ", with:"")
        let strUrl = URLstring.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        self.sd_setImage(with: (NSURL.init(string: strUrl)! as URL), placeholderImage:placeHolderImage , options: SDWebImageOptions.allowInvalidSSLCertificates) { (image, errorr, type, url) in
            
            if(errorr == nil){
                
                if type == SDImageCacheType.none || type == SDImageCacheType.disk{
                    UIView.transition(with: self, duration: 1.0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                        self.image = nil
                        self.image = image
                        
                    }, completion:nil)
                }
                else
                {
                }
                // withFailCompletion(false)
            }else
            {
               withFailCompletion(true)
            }
        }
    }
    func set_sdWebImagewithOutindicator(With URLstring : String ,placeHolderImage: String)  {
//        self.sd_setShowActivityIndicatorView(true)
//        self.sd_setIndicatorStyle(UIActivityIndicatorViewStyle.gray )
        
        //   let imageurl = URLstring.replacingOccurrences(of:" ", with:"")
        let strUrl = URLstring.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        self.sd_setImage(with: (NSURL.init(string: strUrl)! as URL), placeholderImage: UIImage(named:placeHolderImage) , options: SDWebImageOptions.refreshCached) { (image, errorr, type, url) in
            
            if(errorr == nil){
                
                if type == SDImageCacheType.none || type == SDImageCacheType.disk{
                    UIView.transition(with: self, duration: 1.0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                        self.image = nil
                        self.image = image
                        
                    }, completion:nil)
                }
                else
                {
                    self.backgroundColor = UIColor.groupTableViewBackground
                }
            }else
            {
                
            }
        }
    }
    func setImageWithString(_ name : String ,isCircular:Bool,imageUrl:String,placeholderImage :String ,font:UIFont)
    {
        // var displayString : String = "" //[NSMutableString stringWithString:@""];
        
        let newstring : String = name.initials.initials
        self.setImage(
            string: name, color: UIColor.getColorFromAlphabet(newstring) /* UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0)*/, circular:isCircular, textAttributes: [NSAttributedStringKey.font: font,NSAttributedStringKey.foregroundColor : UIColor.white]
            
        )
        self.set_sdWebImage(With: imageUrl, placeHolderImage: self.image!) { (isfailed) in
        }
    }
    func setImageWithStringwithLightBackground(_ name : String ,isCircular:Bool,imageUrl:String,placeholderImage :String)
    {
     // var displayString : String = "" //[NSMutableString stringWithString:@""];
        
        self.setImage(
            string: name, color: UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0), circular:isCircular, textAttributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size: 30)!,NSAttributedStringKey.foregroundColor : UIColor.APPTHEMECOLOR]
        )
        self.set_sdWebImage(With: imageUrl, placeHolderImage: self.image!) { (isfailed) in
    }
    }
    func setImageWithString(_ name : String ,isCircular:Bool,imageUrl:String,placeholderImage :String)
    {
        // var displayString : String = "" //[NSMutableString stringWithString:@""];
        let newstring : String = name.initials.initials
        self.setImage(
            string: name, color: UIColor.getColorFromAlphabet(newstring) /* UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0)*/, circular:isCircular, textAttributes: [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size: 30)!,NSAttributedStringKey.foregroundColor : UIColor.white]
            
        )
        self.set_sdWebImage(With: imageUrl, placeHolderImage: self.image!) { (isfailed) in
        }
    }
     func setImage(string: String?,
                       color: UIColor? = nil,
                       circular: Bool = false,
                       textAttributes: [NSAttributedStringKey: Any]? = nil) {
        
        let image = imageSnap(text: string != nil ? string?.initials : "",
                              color: color ?? .random,
                              circular: circular,
                              textAttributes:textAttributes)
        
        if let newImage = image {
            self.image = newImage
        }
    }
    
    private func imageSnap(text: String?,
                           color: UIColor,
                           circular: Bool,
                           textAttributes: [NSAttributedStringKey: Any]?) -> UIImage? {
        
        let scale = Float(UIScreen.main.scale)
        var size = bounds.size
        if contentMode == .scaleToFill || contentMode == .scaleAspectFill || contentMode == .scaleAspectFit || contentMode == .redraw {
            size.width = CGFloat(floorf((Float(size.width) * scale) / scale))
            size.height = CGFloat(floorf((Float(size.height) * scale) / scale))
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, CGFloat(scale))
        let context = UIGraphicsGetCurrentContext()
        if circular {
            let path = CGPath(ellipseIn: bounds, transform: nil)
            context?.addPath(path)
            context?.clip()
        }
        
        // Fill
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // Text
        if let text = text {
            let attributes = textAttributes ?? [NSAttributedStringKey.foregroundColor: UIColor.white,
                                                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15.0)]
            
            let textSize = text.size(withAttributes: attributes)
            let bounds = self.bounds
            let rect = CGRect(x: bounds.size.width/2 - textSize.width/2, y: bounds.size.height/2 - textSize.height/2, width: textSize.width, height: textSize.height)
            
            text.draw(in: rect, withAttributes: attributes)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}


// MARK: UIColor Helper

extension UIColor {
    
    /// Returns random generated color.
    open static var random: UIColor {
        srandom(arc4random())
        var red: Double = 0
        
        while (red < 0.1 || red > 0.84) {
            red = drand48()
        }
        
        var green: Double = 0
        while (green < 0.1 || green > 0.84) {
            green = drand48()
        }
        
        var blue: Double = 0
        while (blue < 0.1 || blue > 0.84) {
            blue = drand48()
        }
        
        return .init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
    }
    
    open static func colorHash(name: String?) -> UIColor {
        guard let name = name else {
            return .red
        }
        
        var nameValue = 0
        for character in name {
            let characterString = String(character)
            let scalars = characterString.unicodeScalars
            nameValue += Int(scalars[scalars.startIndex].value)
        }
        
        var r = Float((nameValue * 123) % 51) / 51
        var g = Float((nameValue * 321) % 73) / 73
        var b = Float((nameValue * 213) % 91) / 91
        
        let defaultValue: Float = 0.84
        r = min(max(r, 0.1), defaultValue)
        g = min(max(g, 0.1), defaultValue)
        b = min(max(b, 0.1), defaultValue)
        
        return .init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)
    }
 }


// MARK: String Helper

extension String {
    
    public var initials: String {
        var finalString = String()
        var words = components(separatedBy: .whitespacesAndNewlines)
        
        if let firstCharacter = words.first?.first {
            finalString.append(String(firstCharacter))
            words.removeFirst()
        }
        
        if let lastCharacter = words.last?.first {
            finalString.append(String(lastCharacter))
        }
        
        return finalString.uppercased()
    }
}



