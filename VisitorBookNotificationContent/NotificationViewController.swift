//
//  NotificationViewController.swift
//  VisitorBookNotificationContent
//
//  Created by Praveen Sharma on 10/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }

}
