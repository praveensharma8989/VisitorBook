//
//  QuickActionTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen on 19/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

typealias QuickActionClick = (QuickActionClickType) -> (Void)

enum QuickActionClickType : Int {
    
    case TodayClick  = 0
    case WeekClick
    case TotalClick
    case NotificationClick
    case ComplaintClick
    case ResidentClick
}

class QuickActionTableViewCell: UITableViewCell {

    @IBOutlet weak var todayVisitorCountLabel: UILabel!
    @IBOutlet weak var weeklyVisitorCountLabel: UILabel!
    @IBOutlet weak var totalVisitorCountLabel: UILabel!
    @IBOutlet weak var notificationCountLabel: UILabel!
    @IBOutlet weak var allComplaintCountLabel: UILabel!

    var quickActionClick : QuickActionClick? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:ResidentDashboardData){
        
        todayVisitorCountLabel.text = data.today
        weeklyVisitorCountLabel.text = data.weekly
        totalVisitorCountLabel.text = data.total
        notificationCountLabel.text = data.notification
        allComplaintCountLabel.text = data.complaint
        
    }
    
    @IBAction func todayVisitorButton_press(_ sender: Any) {
        if quickActionClick != nil{
            return quickActionClick!(.TodayClick)
        }
    }
    @IBAction func weeklyVisitorButton_press(_ sender: Any) {
        if quickActionClick != nil{
            return quickActionClick!(.WeekClick)
        }
    }
    @IBAction func totalVisitorButton_press(_ sender: Any) {
        if quickActionClick != nil{
            return quickActionClick!(.TotalClick)
        }
    }
    @IBAction func notificationButton_press(_ sender: Any) {
        if quickActionClick != nil{
            return quickActionClick!(.NotificationClick)
        }
    }
    @IBAction func allComplaintButton_press(_ sender: Any) {
        if quickActionClick != nil{
            return quickActionClick!(.ComplaintClick)
        }
    }
    @IBAction func residentButton_press(_ sender: Any) {
        if quickActionClick != nil{
            return quickActionClick!(.ResidentClick)
        }
    }
    
}
