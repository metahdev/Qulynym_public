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

#warning("** means code can be refactored and improved")
/*
 Bugs, which are already found:
  1) Memory Leak with Audio
  2) solved
  3) solved
  4) Eraser draws white on picture !
  5) solved
  6) Auto Layout on IPad: Karaoke Module(video view & Titles), closeBtn
  7) audio leak of the manager at the beginning(maybe is relatable to 1)
 Solutions, which will be integrated further:
  1) TimerController, AudioManager, Videos on another queue
  2) Back segue falling leaves
  3) implemented
  4) implemented
  5) implemented
  6) Tools at Drawing Module !
  7) implemented
  8) implemented
  9) Concurrency at Quiz: can't scroll while audio is playing
  10) Shuffle animation of cards
  11) implemented
  12) implemented
  13) implemented
  14) ModuleView protocol properties get acccessor
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

