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

#warning("bugs and solutions")
/*
 Bugs, which are already found:
  1) Memory Leak with Audio
  2) Beineler's data is messing when a network is slow
  3) SkeletonView doesn't work properly: the first index of the CV is not animating(should look for an alternative) - this version isn't working with skeleton view
 Solutions, which will be integrated further:
  1) Back segue falling leaves
  2) Shuffle animation of cards
  3) ModuleView protocol properties get acccessor
  4) Karaoke Scrolling Text
  5) The audio shouldn't play while user is holding slider(PlaylistItem)
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

