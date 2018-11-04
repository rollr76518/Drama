//
//  UniversalLinkParser.swift
//  Drama
//
//  Created by Ryan on 2018/11/5.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import Foundation

struct UniversalLinkParser {}

extension UniversalLinkParser {
	enum LinkContentType: String {
		case none
		case dramas = "dramas"
	}
	
	enum LinkParseStatus {
		case success(LinkContentType, String)
		case failure
	}
	
	static func link(_ url: URL?) -> LinkParseStatus {
		if let url = url, url.pathComponents.count == 3, url.pathComponents[0] == "/" {
			let type = LinkContentType(rawValue: url.pathComponents[1]) ?? .none
			let id = url.pathComponents[2]
			return .success(type, id)
		} else {
			return .failure
		}
	}
}
