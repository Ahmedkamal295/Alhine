//
//  AppDelegate.swift
//  Student
//
//  Created by Mohamed Lotfy on 4/17/19.
//  Copyright © 2019 e3gaz. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import NotificationBannerSwift
import FirebaseMessaging
import UserNotifications
import FAPanels

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      
        if HelperToken.getapitoken() != nil {
     //  SideMenu()

        }

//        L102Localizer.DoTheMagic()
//        FirebaseApp.configure()
//
//        Messaging.messaging().delegate = self
//        registerForNotifications()
//
//        
//        if #available(iOS 10.0, *) {
//            // For iOS 10 display notification (sent via APNS)
//            UNUserNotificationCenter.current().delegate = self
//            
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: {_, _ in })
//        } else {
//            let settings: UIUserNotificationSettings =
//                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            application.registerUserNotificationSettings(settings)
//        }
//        
//        application.registerForRemoteNotifications()
        
        return true
    }
    func registerForNotifications() {
        // Register for notification: This will prompt for the user's consent to receive notifications from this app.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
        }
    }
    
    func createBackgroundNotificationRequest() -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = "Week End"
        content.subtitle = "Just so you are aware."
        content.body = "We'll be waiting for you back in Week End"
        
        let request = UNNotificationRequest(identifier: "BackgroundNotification", content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 200, repeats: false))
        
        return request
    }
 
    
  
    
    func SideMenu(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //        let leftMenuVC: MenueVC = mainStoryboard.instantiateViewController(withIdentifier: "LeftMenuVC") as! MenueVC
        let rightMenuVC: SideMenueVC = mainStoryboard.instantiateViewController(withIdentifier: "SideMenueVC") as! SideMenueVC
        
              var HomeVc = mainStoryboard.instantiateViewController(withIdentifier: "mainTabbarVC") as! mainTabbarVC
        if HelperToken.getemployee() {
        
  
        }else {
                HomeVc = mainStoryboard.instantiateViewController(withIdentifier: "mainTabbarVC1") as! mainTabbarVC
            
        }
        let PanelController: FAPanelController = FAPanelController()
        
        if L102Language.currentAppleLanguage() == englishLang {
            PanelController.leftPanelPosition = .back
            PanelController.left(rightMenuVC).center(HomeVc)
        }else {
            PanelController.rightPanelPosition = .front
            PanelController.right(rightMenuVC).center(HomeVc)
        }
        //   let rootController: FAPanelController = window?.rootViewController as! FAPanelController
        
        
        window?.rootViewController = PanelController
        window?.makeKeyAndVisible()
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
         let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
       
    Manager.DevicToken = token
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
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
        let container = NSPersistentContainer(name: "Week End")
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


@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
            // handle notification  message
            let dict = userInfo[AnyHashable("aps")] as! [String : Any]
            let al = dict["alert"] as! [String:Any]

            //show bannar
            let banner = NotificationBanner(title: al["title"] as! String, subtitle: (al["body"] as! String ), leftView: nil, rightView: nil, style: BannerStyle.success, colors: CustomBannerColors())
            banner.subtitleLabel?.textAlignment = .right
            banner.titleLabel?.textAlignment = .right
            banner.onTap = {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "NotificationsVC")  as! UINavigationController
//                NotificationVC.notifyClick = true
                self.window?.rootViewController?.tabBarController?.tabBar.isHidden = false
                self.window?.rootViewController?.present(vc, animated: true, completion: nil)
                
                
            }
            banner.show()
        }
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([])
    }
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        print("didReceiveRemoteNotification")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NotificationsVC")  as! UINavigationController
        //NotificationVC.notifyClick = true
        self.window?.rootViewController?.tabBarController?.tabBar.isHidden = false
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        
    }
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("didReceiveRemoteNotification")
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let application = UIApplication.shared
        
        if(application.applicationState == .active){
            print("user tapped the notification bar when the app is in foreground")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "NotificationsVC")  as! UINavigationController
        //    NotificationVC.notifyClick = true
            self.window?.rootViewController?.tabBarController?.tabBar.isHidden = false
            self.window?.rootViewController?.present(vc, animated: true, completion: nil)
            
        }
        
        if(application.applicationState == .inactive)
        {
            //            print("user tapped the notification bar when the app is in background")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "NotificationsVC")  as! UINavigationController
        //    NotificationVC.notifyClick = true
            self.window?.rootViewController?.tabBarController?.tabBar.isHidden = false
            self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        }
        
        /* Change root view controller to a specific viewcontroller */
        // let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerStoryboardID") as? ViewController
        // self.window?.rootViewController = vc
        
        completionHandler()
    }
    
    
}

extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        UserDefaults.standard.setValue(fcmToken, forKey: "mobileToken")
        UserDefaults.standard.synchronize()
        
    }
    
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
        
    }
    
}

//public protocol BannerColorsProtocol {
//    func color(for style: BannerStyle) -> UIColor
//}
class CustomBannerColors: BannerColorsProtocol {
    
    internal func color(for style: BannerStyle) -> UIColor {
        switch style {
        case .danger:   return UIColor(red:0.90, green:0.31, blue:0.26, alpha:1.00)
        case .info:     return .red//165 114 141
        case .none:     return UIColor.clear
        case .success:  return #colorLiteral(red: 0.01153284498, green: 0.6467253566, blue: 0.488014698, alpha: 1)
        case .warning:  return .red
        }
    }
    
}


