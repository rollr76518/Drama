//
//  Int+Extension.swift
//  Drama
//
//  Created by Ryan on 2018/11/4.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import Foundation

extension Int {
	func thousandFormatter() -> String {
		let formatter = NumberFormatter()
		formatter.usesGroupingSeparator = true
		formatter.numberStyle = .decimal
		return formatter.string(from: NSNumber(value: self))!
	}
}
