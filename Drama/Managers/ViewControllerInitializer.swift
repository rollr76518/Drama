//
//  ViewControllerInitializer.swift
//  Drama
//
//  Created by Ryan on 2018/11/5.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import UIKit.UIViewController

struct ViewControllerInitializer {}

extension ViewControllerInitializer {
	static func viewController<T: UIViewController>(_ class: T.Type) -> T {
		let window = UIApplication.shared.keyWindow!
		let navigationController = window.rootViewController as! UINavigationController
		var vc = navigationController.viewControllers.last as? T
		
		if vc == nil {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			vc = storyboard.instantiateViewController(withIdentifier: T.identifier) as? T
			navigationController.pushViewController(vc!, animated: false)
		}
		
		return vc!
	}
}
