//
//  NSString+PS.swift
//  structureCoversionDemo
//
//  Created by praveen on 07/09/17.
//  Copyright © 2017 mobikasa. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
extension String {
    
    func splitWith(_ character: String, atIndex index: Int) -> String {
        var array: [String] = self.components(separatedBy: character)
        
       // return (array.MB_safeObjectAtIndex(index)) ?? ""
        return array[index]
    }
    
    func base64ToImage() -> UIImage {
        let data: Data = Data.init(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0))!//Data(base64encodedstring: self, options: 0)
        
      //  CGRect st
        return UIImage(data: data as Data)!
        
    }
    
    func frombase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }

    func tobase64() -> String {
        
             return Data(self.utf8).base64EncodedString()
        
    }
    
    func hasSpace() -> Bool {
        let array: [String] = self.components(separatedBy: " ")
        return array.count > 1
    }
    
    func range() -> NSRange {
        
        return NSMakeRange(0, self.count)
        
    }
//    func boldAWordFromString(_ word : String ,fromstring:String){
//        let nameString = "Magoo"
//        let string = "Hello my name is \(nameString)"
//        
//        let attributes = [NSFontAttributeName:UIFont.systemFontOfSize(14.0),NSForegroundColorAttributeName: UIColor.black]
//        let boldAttribute = [NSFontAttributeName:UIFont.boldSystemFontOfSize(14.0)]
//        
//        let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
//        
//        let nsString = NSString(string: string)
//        let range = nsString.rangeOfString(nameString)
//        
//        if range.length > 0 { attributedString.setAttributes(boldAttribute, range: range) }
//        
//        someLabel.attributedText = attributedString
//    }
    
    func getDateStringWithFormat(_ dateFormat: String?) -> String {
        
        let dateformatter: DateFormatter = DateFormatter()
        let date: Date = self.getDateObjectFromString()
        dateformatter.timeZone = TimeZone.current
        dateformatter.dateFormat = dateFormat ?? AppConstants.K_DATE_MMDDYYYY
        return dateformatter.string(from: date as Date)
    }
    
    func getDateWithFormat(_ dateFormat: String?) -> Date {
        
        let dateformatter: DateFormatter = DateFormatter()
        let date: Date = self.getDateObjectFromString()
        dateformatter.timeZone = TimeZone.current
        dateformatter.dateFormat = dateFormat! //?? AppConstants.K_DATE_MMDDYYYY
        return date
    }
    
    func getDateObjectFromString() -> Date {
        
        let dateformatter: DateFormatter = DateFormatter()
        dateformatter.timeZone = TimeZone.current //(abbreviation: "UTC")! as TimeZone
        dateformatter.dateFormat = AppConstants.K_DATE_MMDDYYYY
        return dateformatter.date(from: self)! as Date
        
    }
    
    func convertDateToOrdinalDate() -> String{
        
    let date = self.getDateObjectFromString()
//        let day : Int = date.Day()
//
//        return ""
        let calendar = Calendar.current
        let anchorComponents = calendar.dateComponents([.day, .month, .year], from: date)
        
        // Formate
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "MMM, yyyy"
        let newDate = dateFormate.string(from: date)
        
        var day  = "\(anchorComponents.day!)"
        switch (day) {
        case "1" , "21" , "31":
            day.append("st")
        case "2" , "22":
            day.append("nd")
        case "3" ,"23":
            day.append("rd")
        default:
            day.append("th")
        }
        return day + " " + newDate
    }
    
    func setDateFormateForAPI(getFormate: String) -> String{
        
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = getFormate
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "YYYY-MM-dd"
        
        let date: Date? = dateFormatterGet.date(from: self)
        return dateFormatterPrint.string(from: date!)
    }
   

}
