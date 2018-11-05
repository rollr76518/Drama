//
//  AppDelegate.swift
//  Drama
//
//  Created by Ryan on 2018/11/3.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		appURLCacheSetup()

		return true
	}
	
	func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
		return true
	}
	
	func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
		return true
	}

	func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
		
		//可讓瀏覽器或其他 App 透過 http://www.example.com/dramas/:id 當 :id 帶入 1 時，開啟資料中 drama_id 為 1 的戲劇。
		if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
			let linkStatus = UniversalLinkParser.link(userActivity.webpageURL)
			switch linkStatus {
			case .success(let contentType, let id):
				switch contentType {
				case .dramas:
					guard let drama = try? DataManager.loadLocalDrama(id: id) else {
						return false
					}
					let dramaViewController = ViewControllerInitializer.viewController(DramaViewController.self)
					dramaViewController.drama = drama
					return true
				case .none:
					return false
				}
			case .failure:
				return false
			}
		}
		
		return false
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

extension AppDelegate {
	private func appURLCacheSetup() {
		// App URL Cache Setup
		let memory500MB = 500 * 1024 * 1024
		let cache = URLCache(memoryCapacity: memory500MB, diskCapacity: memory500MB, diskPath: nil)
		URLCache.shared = cache
	}
}
