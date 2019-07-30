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
  4) Eraser draws white on picture
  5) Item quit animation is different from pushing back to the rootVC, maybe leak, idk
  6) Auto Layout on IPad: Karaoke Module(video view & Titles), closeBtn
 Solutions, which will be integrated further:
  1) TimerController on another queue
  2) Back segue falling leaves
  3) Video queue
  4) Design Pattern of the Project
  5) Item should quit to their menu
 Eraser icon made by Pixel Buddha at flaticon.com
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

