//
//  AppDelegate.swift
//  AssignmentSubmission
//
//  Created by 國分佑馬 on 2022/12/23.
//

import UIKit
import NCMB
import os

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let applicationKey = "96f80518f9ad6ed1a3ac95ca7bec511991bed8d3ef82ca32fe1c085ed7ae3016"
        let clientKey = "2e780a67e878b94862a4c7a4b30d452e3af7c2aa2cc6f6ca2527ee0cb0f1b40a"
        NCMB.setApplicationKey(applicationKey, clientKey: clientKey)
        // 通知許可の取得
        UNUserNotificationCenter.current().requestAuthorization(
        options: [.alert, .sound, .badge]){
            (granted, _) in
            if granted{
                print("通知許可")
                UNUserNotificationCenter.current().delegate = self
            }
            else{
                print("通知許可しない")
            }
        }
        return true
    }


    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
 
        os_log("Notified")
        completionHandler([.sound, .alert ])
    }
}

