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
        let rootVC = MainMenuViewController()
        let navigationController = UINavigationController(rootViewController: rootVC)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
    }

    func applicationWillTerminate(_ application: UIApplication) {
        AudioPlayer.backgroundAudioPlayer.stop()
        AudioPlayer.scenesAudioPlayer.stop()
        AudioPlayer.contentAudioPlayer.stop()
        PersistentService.saveContext()
    }
}

