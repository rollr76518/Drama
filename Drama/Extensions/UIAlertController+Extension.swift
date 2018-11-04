//
//  UIAlertController+Extension.swift
//  Drama
//
//  Created by Ryan on 2018/11/4.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import UIKit

extension UIAlertController {
	convenience init(title: String?, message: String?, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
		self.init(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default, handler: handler)
		self.addAction(action)
	}
}
