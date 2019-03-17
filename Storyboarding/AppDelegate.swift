//
//  AppDelegate.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/11/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

/*
 TODO:
    Element Table View
        - Create sections for element table view - done
        - make sections expandable/collapsable
            -create button for expanding/collapsing
                -create button in the view
                -create button functionality in the controller
                -connect using delegates and protocols
 
        - be able to delete rows from sections
    Create model for receiving JSON data from API
    Implement Networking layer (GET route)
    Figure out how to handle data
        - figure out what structure to create to hold data
        - figure out how to distribute data in application and display it
            - randomize
    Persistence
 
 IMPROVEMENTS/FIX:
    Fix genre view screen size
    make design consistent throughout screens
        - Make Idea View tableview match other screens
*/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /*
         create main view and nav controller
         */
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav1 = UINavigationController()
        let mainView = IdeaViewController(nibName: nil, bundle: nil)
        nav1.viewControllers = [mainView]
        self.window!.rootViewController = nav1
        self.window?.makeKeyAndVisible()

        return true
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
    }
}

