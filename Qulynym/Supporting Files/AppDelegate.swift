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

#warning("TODO")
/*
 1. UI & Unit tests
 2. Practical instruments
 3. Refactoring
 4. Firebase
*/

/*
 Refactor:
  1) MenuRouter + MenuViewController
  2) CustomImageView(maybe delegate something to DataFetchAPI)
  3) BeineViewController(architecture & nextVideo methods
  4) ImageCollectionViewCell
  5) DrawingViewControllers into one view, overall code logic(touchUpOutside)
  6) Quiz Module(concurrency)
  7) ModuleView protocol properties get acccessor & architecture overall
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

