/*
 * Kulynym
 * AppDelegate.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit
import CoreData

/*
 Bugs, which are already found:
  1) Memory Leak with Audio
  2) Audio queue isn't optimizing the main thread
  3) Preschool module's scroll view - content is ambigious
 Solutions, which will be integrated further:
  1) TimerController on another queue
  2) Back segue animated, falling toys 
  3) Video queue
  4) Interactors are slowing down the application
  5) RootViewController 
 */

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupWindow()
        window?.makeKeyAndVisible()
        AudioPlayer.turnOnBackgroundMusic()
        
        return true
    }
    
    func setupWindow() {
        let rootVC = MenuViewController()
        let navigationController = UINavigationController(rootViewController: rootVC)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
    }
}

