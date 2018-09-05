//
//  NSDate+PS.swift
//  structureCoversionDemo
//
//  Created by praveen on 08/09/17.
//  Copyright © 2017 mobikasa. All rights reserved.
//

import Foundation

let componentFlags: Set<Calendar.Component> = [.year,.month,.day,.weekday,.hour,.minute,.second,.weekdayOrdinal]

extension Date {
    
    static let D_MINUTE = 60
    static let D_HOUR   = 3600
    static let D_DAY    = 86400
    static let D_WEEK   = 604800
    static let D_YEAR   = 31556926
    
//    let componentFlags: UInt = (YearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
    
    
    
    static var currentCalender: Calendar {
        var sharedCalendar: Calendar? = nil
        if sharedCalendar == nil {
            sharedCalendar = Calendar.autoupdatingCurrent
        }
        sharedCalendar?.timeZone = NSTimeZone.default
        sharedCalendar?.locale = NSLocale.current
        return sharedCalendar!
     }
    
// MARK: Relative Dates
    
    static func dateWithDaysFromNow(days :Int) -> Date{
        
        return dateByAddingDays(dDays:days)
    }
    
    static func dateWithdaysBeforeNow(days :Int) -> Date{
        
        return dateBySubtractingDays(dDays:days)
        
    }
    
    static func dateByAddingDays(dDays :Int) -> Date{
        
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: dDays, to: Date(), options: [])!
        
    }
    static func dateBySubtractingDays(dDays :Int) -> Date{
    
        return dateByAddingDays(dDays: dDays * -1)
        
    }

    static func dateTomorrow() -> Date {
        return dateWithDaysFromNow(days: 1)
    }
    
    static func dateYesterday() -> Date {
        return dateWithdaysBeforeNow(days: 1)
    }
    
    static func dateWith(hoursFromNow dHours: Int) -> Date{
    
        let aTimeInterval: TimeInterval = TimeInterval(Float(Date().timeIntervalSinceReferenceDate) + Float(Date.D_HOUR * dHours))
        
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        
        return newDate
    }
    
    static func dateWith(hoursBeforeNow dHours: Int) -> Date{
        
        let aTimeInterval: TimeInterval = TimeInterval(Float(Date().timeIntervalSinceReferenceDate) - Float(Date.D_HOUR * dHours))
        
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        
        return newDate
    }

    static func dateWith(minutesFromNow dMinutes: Int) -> Date{
        
        let aTimeInterval: TimeInterval = TimeInterval(Float(Date().timeIntervalSinceReferenceDate) + Float(Date.D_MINUTE * dMinutes))
        
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        
        return newDate
    }
    
    static func dateWith(minutesBeforeNow dMinutes: Int) -> Date{
        
        let aTimeInterval: TimeInterval = TimeInterval(Float(Date().timeIntervalSinceReferenceDate) - Float(Date.D_MINUTE * dMinutes))
        
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        
        return newDate
    }
    
    static func UTCToLocalDateTimeStyleForOtheruseDish(date: String?) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let tempDate = date, let dt = dateFormatter.date(from: tempDate) else
        {
            return ""
        }
        
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return timeSinceDate(dt)
        
       // return dateFormatter.string(from: dt!)
    }
   
    static func UTCToLocalDateTimeStyle(date: String) -> String {
            if(date == ""){
               return ""
             }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            
           guard let dt = dateFormatter.date(from: date) else
           {
            return ""
           }
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "MM/dd/yyyy"
            //  return timeSinceDate(dt!)
            
            return dateFormatter.string(from: dt)
        
     
    }
    static func timeSinceDate(_ date:Date, numericDates:Bool = false) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let dateFormatter = DateFormatter()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        let locale = NSLocale.current
        let formatter : String = DateFormatter.dateFormat(fromTemplate: "j", options:0, locale:locale)!
        if (components.year! >= 2) {
            dateFormatter.dateFormat = "dd MMM yy"
            return "\(dateFormatter.string(from: date))"
        } else if (components.year! >= 1){
            dateFormatter.dateFormat = "dd MMM yy "
            if (numericDates){
                return "\(dateFormatter.string(from: date))"
            } else {
                return "\(dateFormatter.string(from: date))"
            }
        } else if (components.month! >= 2) {
            dateFormatter.dateFormat = "dd MMM"
            return "\(dateFormatter.string(from: date))"
        } else if (components.month! >= 1){
            dateFormatter.dateFormat = "dd MMM"
            if (numericDates){
                return "\(dateFormatter.string(from: date))"
            } else {
                return "\(dateFormatter.string(from: date))"
            }
        } else if (components.weekOfYear! >= 2) {
            dateFormatter.dateFormat = "dd MMM"
            return "\(dateFormatter.string(from: date))"
        } else if (components.weekOfYear! >= 1){
            dateFormatter.dateFormat = "dd MMM "
            if (numericDates){
                return "\(dateFormatter.string(from: date))"
            } else {
                return "\(dateFormatter.string(from: date))"
            }
        } else if (components.day! >= 2) {
            dateFormatter.dateFormat = "EEE "
            return "\(dateFormatter.string(from: date))"
        } else if (components.day! >= 1){
            dateFormatter.dateFormat = "EEE"
            if (numericDates){
                
                return "\(dateFormatter.string(from: date))"
            } else {
                return "\(dateFormatter.string(from: date))"
            }
        } else if (components.hour! >= 2) {
            dateFormatter.dateFormat = "HH:mm "
            return "Today"
        } else if (components.hour! >= 1){
            if (numericDates){
                dateFormatter.dateFormat = "HH:mm "
                return "Today"
            } else {
                return "Today"
            }
        }
        else
        {
            dateFormatter.dateFormat = "HH:mm "
            return "Today"
        }
        
    }
    
    static func UTCToLocalDateTimeStyleforplanner(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: dt!)
    }
    
    //this is for planner
    static func UTCToLocalDate(with date:Date) -> Date {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let dt = dateFormatter.string(from:date)
        
        /// locale date STring from UTC String
        let localeDateSTring = UTCToLocalDateTimeStyleforplanner(date: dt)
        
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: localeDateSTring)!
    }
//    static func UTCToLocalDateWithFormat(with date:Date ,format :String) -> Date {
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//
//        let dt = dateFormatter.string(from:date)
//
//        /// locale date STring from UTC String
//        let localeDateSTring = UTCToLocalDateTimeStyle(date: dt)
//
//        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0)
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//
//        return dateFormatter.date(from: localeDateSTring)!
//    }
    
    static func UTCToLocalDateWithTimeStyle(date: String) -> String {
        if(date.count == 0){
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        
        
        return timeAgoSinceDate(dt!)
        
    }
    
    static func UTCToDateWithTimeStyle(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: dt!)
        
    }
    
    static func LocalToUTCDateTimeStyle(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: dt!)
        
    }
    
    func stringWithDateStyle(format: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    func stringWithDateStyle(dateStyle: DateFormatter.Style, time timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
    
    var shortString : String {
        
        return self.stringWithDateStyle(dateStyle:.short, time: .short)
    }
    
    var  shortTimeString : String{
        
        return self.stringWithDateStyle(dateStyle: .none, time: .short)
    }
    
    var shortDateString : String {
        
        return self.stringWithDateStyle(dateStyle: .short, time: .none)
    }
    
    var mediumString : String {
        
        return self.stringWithDateStyle(dateStyle: .medium, time: .medium)
    }
    var mediumTimeString : String {
        
        return self.stringWithDateStyle(dateStyle: .none, time: .medium)
    }
    var mediumDateString : String {
        
        return self.stringWithDateStyle(dateStyle: .medium, time: .none)
    }
    var longString : String {
        
        return self.stringWithDateStyle(dateStyle: .long, time: .long)
    }
    var longTimeString : String {
        
        return self.stringWithDateStyle(dateStyle: .none, time: .long)
    }
  
    var longDateString : String {
        
        return self.stringWithDateStyle(dateStyle: .long, time: .none)
    }
    
    func isEqualtoDateIgnoringTime(aDate: Date) -> Bool {
        let components1: DateComponents? = Date.currentCalender.dateComponents(componentFlags, from: self)// Date.components(componentFlags, from: self)
        let components2: DateComponents? =  Date.currentCalender.dateComponents(componentFlags, from: aDate)
        return (components1?.year == components2?.year) && (components1?.month == components2?.month) && (components1?.day == components2?.day)
    }
    func isPastDate() -> Bool {
        
        if(self < Date()){
            
            if(self.isEqualtoDateIgnoringTime(aDate: Date()) == true){
               return false
            }
            return true
        }
        
        
        return false
        //return (self as NSDate).earlierDate(Date()) == self
    }
    func isFutureDate() -> Bool {
        if(self > Date()){
            return true
        }
        return false
       // return (self as NSDate).laterDate(Date()) == self
    }
    func isToday() -> Bool {
        return isEqualtoDateIgnoringTime(aDate: Date())
    }
    
    func isTomorrow() -> Bool {
        return isEqualtoDateIgnoringTime(aDate: Date.dateTomorrow())
    }
    
    func isYesterday() -> Bool {
        return isEqualtoDateIgnoringTime(aDate: Date.dateYesterday())
    }
    
    
    func isInSameWeek(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear)
    }
    func isInSameMonth(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }
    func isInSameYear(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .year)
  }
    
    func isThisYear() -> Bool {
        // Thanks, baspellis
        return isInSameYear(date: Date())
    }
    
    func isNextYear() -> Bool {
        let components1: DateComponents? = Date.currentCalender.dateComponents([.year], from: self)
        //.components(NSYearCalendarUnit, from: self)
        let components2: DateComponents? = Date.currentCalender.dateComponents([.year], from: Date())
        
        return ((components1?.year)! == ((components2?.year)! + 1))
    }
    
    func isLastYear() -> Bool {
        let components1: DateComponents? = Date.currentCalender.dateComponents([.year], from: self)
        let components2: DateComponents? = Date.currentCalender.dateComponents([.year], from: Date())
        return ((components1?.year)! == ((components2?.year)! - 1))
    }
    func Month() -> Int{
        let components1: DateComponents? = Date.currentCalender.dateComponents([.month], from: self)
        return (components1?.month)!
    }
    func Year() -> Int{
        let components1: DateComponents? = Date.currentCalender.dateComponents([.year], from: self)
        return (components1?.year)!
    }
    
    func Day() -> Int{
        let components1: DateComponents? = Date.currentCalender.dateComponents([.day], from: self)
        return (components1?.day)!
    }
    func convertMillisecondToDate(miliseconds :Double) -> Date {
        let date = Date(timeIntervalSince1970: miliseconds/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = AppConstants.K_DATE_MMDDYYYY //"yyyy-MM-dd HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
      //  dateFormatter.date(from: strDate)
        return dateFormatter.date(from: strDate)!
    }
    
   static func timeAgoSinceDate(_ date:Date, numericDates:Bool = false) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let dateFormatter = DateFormatter()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
    
        let locale = NSLocale.current
        let formatter : String = DateFormatter.dateFormat(fromTemplate: "j", options:0, locale:locale)!
        if formatter.contains("a") {
            if (components.year! >= 2) {
                dateFormatter.dateFormat = "dd MMM yy hh:mm a"
                return "\(dateFormatter.string(from: date))"
            } else if (components.year! >= 1){
                dateFormatter.dateFormat = "dd MMM yy hh:mm a"
                if (numericDates){
                    return "\(dateFormatter.string(from: date))"
                } else {
                    return "\(dateFormatter.string(from: date))"
                }
            } else if (components.month! >= 2) {
                dateFormatter.dateFormat = "dd MMM hh:mm a"
                return "\(dateFormatter.string(from: date))"
            } else if (components.month! >= 1){
                dateFormatter.dateFormat = "dd MMM hh:mm a"
                if (numericDates){
                    return "\(dateFormatter.string(from: date))"
                } else {
                    return "\(dateFormatter.string(from: date))"
                }
            } else if (components.weekOfYear! >= 2) {
                dateFormatter.dateFormat = "dd MMM hh:mm a"
                return "\(dateFormatter.string(from: date))"
            } else if (components.weekOfYear! >= 1){
                dateFormatter.dateFormat = "dd MMM hh:mm a"
                if (numericDates){
                    return "\(dateFormatter.string(from: date))"
                } else {
                    return "\(dateFormatter.string(from: date))"
                }
            } else if (components.day! >= 2) {
                dateFormatter.dateFormat = "EEE hh:mm a"
                return "\(dateFormatter.string(from: date))"
            } else if (components.day! >= 1){
                dateFormatter.dateFormat = "EEE hh:mm a"
                if (numericDates){
                    
                    return "\(dateFormatter.string(from: date))"
                } else {
                    return "\(dateFormatter.string(from: date))"
                }
            } else if (components.hour! >= 2) {
                dateFormatter.dateFormat = "hh:mm a"
                return "Today - \(dateFormatter.string(from: date))"
            } else if (components.hour! >= 1){
                if (numericDates){
                    dateFormatter.dateFormat = "hh:mm a"
                    return "Today - \(dateFormatter.string(from: date))"
                } else {
                    return "Today - \(dateFormatter.string(from: date))"
                }
            }
            else
            {
                dateFormatter.dateFormat = "hh:mm a"
                return "Today - \(dateFormatter.string(from: date))"
            }
        }
        else
        {
            if (components.year! >= 2) {
                dateFormatter.dateFormat = "dd MMM yy HH:mm "
                return "\(dateFormatter.string(from: date))"
            } else if (components.year! >= 1){
                dateFormatter.dateFormat = "dd MMM yy HH:mm "
                if (numericDates){
                    return "\(dateFormatter.string(from: date))"
                } else {
                    return "\(dateFormatter.string(from: date))"
                }
            } else if (components.month! >= 2) {
                dateFormatter.dateFormat = "dd MMM HH:mm "
                return "\(dateFormatter.string(from: date))"
            } else if (components.month! >= 1){
                dateFormatter.dateFormat = "dd MMM HH:mm "
                if (numericDates){
                    return "\(dateFormatter.string(from: date))"
                } else {
                    return "\(dateFormatter.string(from: date))"
                }
            } else if (components.weekOfYear! >= 2) {
                dateFormatter.dateFormat = "dd MMM HH:mm "
                return "\(dateFormatter.string(from: date))"
            } else if (components.weekOfYear! >= 1){
                dateFormatter.dateFormat = "dd MMM HH:mm "
                if (numericDates){
                    return "\(dateFormatter.string(from: date))"
                } else {
                    return "\(dateFormatter.string(from: date))"
                }
            } else if (components.day! >= 2) {
                dateFormatter.dateFormat = "EEE HH:mm "
                return "\(dateFormatter.string(from: date))"
            } else if (components.day! >= 1){
                dateFormatter.dateFormat = "EEE HH:mm "
                if (numericDates){
                    
                    return "\(dateFormatter.string(from: date))"
                } else {
                    return "\(dateFormatter.string(from: date))"
                }
            } else if (components.hour! >= 2) {
                dateFormatter.dateFormat = "HH:mm "
                return "Today - \(dateFormatter.string(from: date))"
            } else if (components.hour! >= 1){
                if (numericDates){
                    dateFormatter.dateFormat = "HH:mm "
                    return "Today - \(dateFormatter.string(from: date))"
                } else {
                    return "Today - \(dateFormatter.string(from: date))"
                }
            }
            else
            {
                dateFormatter.dateFormat = "HH:mm "
                return "Today - \(dateFormatter.string(from: date))"
            }
    
    }
}
}
