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

#warning("do some refactoring of the project and make a review")
/*
 Bugs, which are already found:
  1) Memory Leak with Audio
  2) Audio queue isn't optimizing the main thread
  3) solved
  4) Eraser draws white on picture !
  5) Item quit animation is different from pushing back to the rootVC, maybe leak, idk !
  6) Auto Layout on IPad: Karaoke Module(video view & Titles), closeBtn
  7) There are some shady business happening between Audios and threads
 Solutions, which will be integrated further:
  1) TimerController on another queue
  2) Back segue falling leaves
  3) Video queue
  4) Design Pattern of the Project(Karaoke Module especially) !
  5) Item should quit to their menu !
  6) Tools at Drawing Module !
  7) Scroll View at Alert for instructions of the UI !
  8) Names Refactoring: controller, view !
  9) Concurrency at Quiz: can't scroll while audio is playing
  10) Shuffle animation of cards
  11) Messages UserDefaults !
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

