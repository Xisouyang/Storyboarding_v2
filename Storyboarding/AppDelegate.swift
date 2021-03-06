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
        - Create sections for element table view - DONE
        - make sections expandable/collapsable
            -create button for expanding/collapsing
                -create button in the view - DONE
                -create button functionality in the controller
                -connect using delegates and protocols or class instance - DONE
 
        - be able to delete rows from sections
    Create model for receiving JSON data from API - DONE
    Implement Networking layer (GET route) - partially DONE
        - create model for data - done
        - change implementation of API to not require auth for getAllStories route - DONE
        Figure out how to handle data
            - figure out what structure to create to hold data -DONE
            - figure out how to distribute data in application and display it - DONE
                - randomize
    Persistence
 
 IMPROVEMENTS/FIX:
    **Fix bug where if I write on 1st cell of one section, it writes it for all other 1st cells
      of other sections - DONE
        - Figure out what textview delegate method to use, do proof of concept to see how it works - DONE
        - Create section property on cell - DONE
        - Write logic to check where user input should be accepted onto the textview - DONE
            - Check what section we're on, decide what to do based on that section - DONE
                - What should I compare that section to?
                - Do I even need to compare that section?
                - Maybe set a boolean to disable or enable textview
    **Replace hardcoded url with dynamically generated url
    Fix genre view screen size
    Fix padding for genre view text
    make design consistent throughout screens
        - Make Genre View tableview match other screens - DONE
        - Make Idea View tableview match other screens
*/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /*
         create main view and nav controller
         */
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav1 = UINavigationController()
        nav1.navigationBar.barStyle = .black
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

