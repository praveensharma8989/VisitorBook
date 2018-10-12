//
//  AppDelegate.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 03/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import FirebaseCore
import UserNotifications
import FirebaseMessaging
import FirebaseInstanceID
import FAPanels


enum PushNotificationEnum: String {
    case Notification       = "Notification"
    case GuardNotif         = "GuardNotif"
    case GuardSOS           = "GuardSOS"
    case Staff              = "Staff"
    case Expected           = "Expected"
    case BlogLikes          = "BlogLikes"
    case Events             = "Events"
    case BlogComment        = "BlogComment"
    case Complain           = "Complain"
    case RWAReply           = "RWAReply"
    case GuardReply         = "GuardReply"
    case FlatReply          = "FlatReply"
    case SOSReply           = "SOSReply"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let sharedInstance =  UIApplication.shared.delegate as! AppDelegate
    var window: UIWindow?
    var currentView: UIViewController?
    var gateKeeperSelectedIndex : Int = 0
    var isScannerApear : Bool = false
    let notificationDelegate = SampleNotificationDelegate()
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusbar.backgroundColor = UIColor.red
        }
        registerPushNotification(application)
        
//        loadExampleAppStructure()
        appInilize()
        
        if launchOptions != nil
        {
            if let userInfo : [String:AnyObject] = launchOptions![UIApplicationLaunchOptionsKey.remoteNotification] as? [String:AnyObject]
            {
                pushHandling(with:userInfo)
            }
            else
            {
                
            }
        }
        
        // Override point for customization after application launch.
        return true
    }
    
    func appInilize(){
        
        
        AppIntializer.shared.setupIntial()
        IQKeyboardManager.shared.enable = true
        
    }

    func ConnectFCM(){
        
        Messaging.messaging().isAutoInitEnabled = true
        Messaging.messaging().shouldEstablishDirectChannel = true
        
        
    }
    
    
    
//    fileprivate func loadExampleAppStructure() {
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.makeKeyAndVisible()
//
//        let storyboard = UIStoryboard.init(name: "Resident", bundle: nil)
//
//        let ContentController = storyboard.instantiateViewController(withIdentifier:"HeaderViewViewController") as! HeaderViewViewController
//
//        let LeftMenuController = storyboard.instantiateViewController(withIdentifier:"LeftMenuViewController") as! LeftMenuViewController
//
//        let sideMenuController = PGSideMenu(animationType: .slideIn)
//        let contentController = ContentController
//        let leftMenuController = LeftMenuController
//        sideMenuController.addContentController(contentController)
//        sideMenuController.addLeftMenuController(leftMenuController)
//        self.window?.rootViewController = sideMenuController
//    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//        Messaging.messaging().shouldEstablishDirectChannel = false
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        ConnectFCM()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "VisitorBook")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func registerPushNotification(_ application: UIApplication) {
        // For iOS 10 display notification (sent via APNS)
        
        application.registerForRemoteNotifications()
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions) {(isGranted, error) in

                if (error != nil){

                }else{
                    UNUserNotificationCenter.current().delegate = self
                    Messaging.messaging().delegate = self

                }

        }
        
//
//        print(#function)
//        if #available(iOS 10.0, *) {
//            // For iOS 10 display notification (sent via APNS)
//            UNUserNotificationCenter.current().delegate = self
//
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: {_, _ in })
//
//            // For iOS 10 data message (sent via FCM)
//            Messaging.messaging().delegate = self
//
//        } else {
//            let settings: UIUserNotificationSettings =
//                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            application.registerUserNotificationSettings(settings)
//
//        }
        application.registerForRemoteNotifications()
        FirebaseApp.configure()
        
        // For iOS 10 data message (sent via FCM)
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //When the notifications of this code worked well, there was not yet.
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            debugPrint("Message ID: \(messageID)")
        }
        
        if(application.applicationState == UIApplicationState.inactive)
        {
            // checking that userInfo is having dictionary type or not
            if userInfo is [String : AnyHashable]
            {
                pushHandling(with:userInfo as! [String : AnyObject])
            }
            
        }
        // Print full message.
        debugPrint(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        debugPrint(userInfo)
        
        completionHandler(.newData)
    }
    
    // showing push notification
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        
            // checking that userInfo is having dictionary type or not
        if userInfo is [String : AnyHashable]
        {
            pushHandling(with:userInfo as! [String : AnyObject])
        }
            
        
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        
        let content = notification.request.content
        // Process notification content
        print("\(content.userInfo)")
        completionHandler([.alert, .sound]) // Display notification as
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
//
//        // Print full message.
//        print(userInfo)
//
//        // Change this to your preferred presentation option
//        completionHandler([])
    }
    
    
    func tokenRefreshNotification(_ notification: Notification) {
        print(#function)
        if let refreshedToken = InstanceID.instanceID().token() {
//            log.info("Notification: refresh token from FCM -> \(refreshedToken)")
        }
        
        // Connect to FCM since connection may have failed when attempted before having a token.
        ConnectFCM()
        
    }
    
    
}

// [START ios_10_data_message_handling]
extension AppDelegate : MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        CommanFunction.instance.setFCMTocken(user: fcmToken)
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }
    
    
    
    // Receive data message on iOS 10 devices while app is in the foreground.
    func application(received remoteMessage: MessagingRemoteMessage) {
        debugPrint(remoteMessage.appData)
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        
        
        
        print(messaging.fcmToken)
    }
    
    func pushHandling(with userInfo :[String:AnyObject]){
        
        if let purpose : PushNotificationEnum = PushNotificationEnum(rawValue: userInfo["gcm.notification.purpose"] as! String){
            var nsvigationNew = UINavigationController()
            
            var RVC = FAPanelController()
            if (UIApplication.shared.keyWindow?.rootViewController!.isKind(of: FAPanelController.self))!{
                RVC = UIApplication.shared.keyWindow?.rootViewController as! FAPanelController
                nsvigationNew = RVC.center as! UINavigationController
            }
//            if (UIApplication.shared.keyWindow?.window?.rootViewController?.isEqual())!{
//
//            }
            
            
            let GateKeeperStoryboard = UIStoryboard.init(name: "GateKeeper", bundle: nil)
            let ResidentStoryboard = UIStoryboard.init(name: "Resident", bundle: nil)
            
            
            switch purpose{
            case .RWAReply:
                
                let ResidentChatVC = ResidentStoryboard.instantiateViewController(withIdentifier: "ResidentChatViewController") as! ResidentChatViewController
                ResidentChatVC.fromId = (userInfo["gcm.notification.name"] as! String)
                
                nsvigationNew.pushViewController(ResidentChatVC, animated: true)
                
            case .Notification:
                
                let NotificationVC = ResidentStoryboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
                
                nsvigationNew.pushViewController(NotificationVC, animated: true)
            
            case .BlogLikes:
                
                let PostListVC = ResidentStoryboard.instantiateViewController(withIdentifier: "PostListViewController") as! PostListViewController
                PostListVC.postID = (userInfo["gcm.notification.id"] as! String)
                nsvigationNew.pushViewController(PostListVC, animated: true)
                
            case .BlogComment:
                
                let PostListVC = ResidentStoryboard.instantiateViewController(withIdentifier: "PostListViewController") as! PostListViewController
                PostListVC.postID = (userInfo["gcm.notification.id"] as! String)
                nsvigationNew.pushViewController(PostListVC, animated: true)
                
            case .Complain:
                
                let ComplaintDetailVC = ResidentStoryboard.instantiateViewController(withIdentifier: "ComplaintDetailViewController") as! ComplaintDetailViewController
                ComplaintDetailVC.complainID = (userInfo["id"] as! String)
                nsvigationNew.pushViewController(ComplaintDetailVC, animated: true)
                
            default:
                break
            }
        }
        
    }
    
}

