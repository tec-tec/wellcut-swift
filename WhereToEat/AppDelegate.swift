//
//  AppDelegate.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 14/12/2016.
//  Copyright © 2016 Ludovic Ollagnier. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    var backgroundTaskID: UIBackgroundTaskIdentifier!
    var timer: Timer?
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.ping), userInfo: nil, repeats: true)

        backgroundTaskID = application.beginBackgroundTask(withName: "Task") {
            // Clean up any unfinished task business by marking where you
            // stopped or ending the task outright.
            
            print("Times up!")
            application.endBackgroundTask(self.backgroundTaskID)
            self.backgroundTaskID = UIBackgroundTaskInvalid
        }
        
        // Start the long-running task and return immediately.
//        DispatchQueue.global(qos: .background).async {
            // Do the work associated with the task, preferably in chunks.
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.ping), userInfo: nil, repeats: true)
            //When finished, end background task and invalidate the ID
            application.endBackgroundTask(self.backgroundTaskID)
            self.backgroundTaskID = UIBackgroundTaskInvalid
//        }

    }
    
    func ping() {
        print("Ping \(Date())")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        timer?.invalidate()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        
    }


}

