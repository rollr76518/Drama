//
//  Date+Extension.swift
//  Drama
//
//  Created by Ryan on 2018/11/3.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import Foundation

extension Date {
	func formatter(_ string: String) -> String {
		let formatter = DateFormatter()
		formatter.locale = Locale.current
		formatter.dateFormat = string
		return formatter.string(from: self)
	}
}
