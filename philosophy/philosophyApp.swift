//
//  philosophyApp.swift
//  philosophy
//
//  Created by 市川マサル on 2022/08/24.
//

import SwiftUI
import Firebase
@main
struct philosophyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
            func application(_ application: UIApplication,
                             didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
                FirebaseApp.configure()
                return true
            }
    }
}
