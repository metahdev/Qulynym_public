/*
 * Qulynym
 * AppDelegate.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit
import CoreData

#warning("resolve before the uploading:")
/*
 Call ConnectionWarning:
 if it takes longer than 25 seconds for data to fetch
 */

#warning("bugs and solutions")
/*
 Bugs, which are already found:
  1) Memory Leak with Audio
  2) SkeletonView doesn't work properly: the first index of the CV is not animating(should look for an alternative) - this version isn't working with skeleton view
  3) IPad Drawing View brush width
  4) PlaylistItem timer bug
  5) Bug with content changing after several button touches
  6) Some icons are not resizing(icons8.com and etc)
 Solutions, which will be integrated further:
  1) Back segue falling leaves
  2) Shuffle animation of cards
  3) ModuleView protocol properties get acccessor
  4) Karaoke Scrolling Text
  5) Improve PlaylistItem logic
  6) Check whether concurrency is performing normally in all modules 
  7) Blur effect when new beineler are loading
 */

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var orientationLock = UIInterfaceOrientationMask.landscape
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
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock 
    }
}

