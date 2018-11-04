//
//  NSObject+Extension.swift
//  Drama
//
//  Created by Ryan on 2018/11/4.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import Foundation

extension NSObject {	
	static var identifier: String {
		return String(describing: self).components(separatedBy: ".").last!
	}
}
