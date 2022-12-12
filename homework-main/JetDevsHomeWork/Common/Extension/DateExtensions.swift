//
//  DateExtensions.swift
//  JetDemo
//
//  Created by Virani Bhavesh Madhavajibhai on 12/12/22.
//

import Foundation

extension Date {
    func years(from date: Date) -> Int {
            return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
        }
    func months(from date: Date) -> Int {
            return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
        }
        /// Returns the amount of weeks from another date
//        func weeks(from date: Date) -> Int {
//            return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
//        }
        /// Returns the amount of days from another date
        func days(from date: Date) -> Int {
            return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
        }
    func dateDisplay(from date: Date) -> String {
        let  days: Int = Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
        
        var strDisplay = ""
        let year: Int = days / 365;
        var reminderDay: Int = days % 365;
        let month: Int = reminderDay / 30;
        reminderDay = reminderDay % 30;
        if year > 0 {
            strDisplay =  year > 1 ? "\(year) years" : "\(year) year"
        }
        if month > 0 {
//           let monthString = month > 1 ? "\(month) months" : "\(month) month"
            
            strDisplay = strDisplay == "" ? (month > 1 ? "\(month) months" : "\(month) month") : (month > 1 ? "\(strDisplay) \(month) months" : " \(strDisplay) \(month) month")
        }
        if reminderDay > 0 {
            strDisplay = strDisplay == "" ? (reminderDay > 1 ? "\(reminderDay) days" : "\(reminderDay) day") : (reminderDay > 1 ? "\(strDisplay) \(reminderDay) days" : " \(strDisplay) \(reminderDay) day")

        }
        
        return strDisplay
    }
    func offsetLong(from date: Date) -> String {
        if years(from: date) > 0 {
            return years(from: date) > 1 ? "\(years(from: date)) years ago" : "\(years(from: date)) year ago"
        }
        if months(from: date) > 0 {
            return months(from: date) > 1 ? "\(months(from: date)) months ago" : "\(months(from: date)) month ago"
        }
        
        if days(from: date) > 0 {
            return days(from: date) > 1 ? "\(days(from: date)) days ago" : "\(days(from: date)) day ago"
        }
        
        
       
        return ""
    }
}
