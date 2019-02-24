/*
 * Kulynym
 * File.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var rootVC: UIViewController?
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        window?.makeKeyAndVisible()
        AudioManager.turnOnBackgroundMusic()
        return true
    }
    
    func setupWindow() {
        rootVC = ItemViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootVC
    }

    func applicationWillTerminate(_ application: UIApplication) {
        AudioManager.backgroundAudioPlayer.stop()
        AudioManager.extraAudioPlayer.stop()
        PersistentService.saveContext()
    }
}

