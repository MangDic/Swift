//
//  AppDelegate.swift
//  NaverOAuthTest
//
//  Created by 이명직 on 2021/06/11.
//

import UIKit
import KakaoSDKCommon
import NaverThirdPartyLogin
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 구글
        GIDSignIn.sharedInstance()?.clientID = "-.apps.googleusercontent.com"
        
        // 네이버
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        instance?.isNaverAppOauthEnable = true
        instance?.isInAppOauthEnable = true
        instance?.setOnlyPortraitSupportInIphone(true)
        instance?.appName = (Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String) ?? ""
        instance?.serviceUrlScheme = "mangdic"
        instance?.consumerKey = "-"
        instance?.consumerSecret = "-"
        
        // 카카오
        KakaoSDKCommon.initSDK(appKey: "-")
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let scheme = url.scheme else { return true }
        
        if scheme.contains("mangdic") {
            let result = NaverThirdPartyLoginConnection.getSharedInstance().receiveAccessToken(url)
            if result == CANCELBYUSER {
                print("result: \(result)")
            }
            return true
        }
        else if scheme.contains("com.googleusercontent.apps") {
            return GIDSignIn.sharedInstance().handle(url)
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
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

