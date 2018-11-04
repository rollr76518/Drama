//
//  ResponseModel.swift
//  Drama
//
//  Created by Ryan on 2018/11/3.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import Foundation


struct ResponseModel<T: Decodable> {
	var data: [T]
}

extension ResponseModel: Decodable {
	enum CodingKeys: String, CodingKey {
		case data
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decode([T].self, forKey: .data)
	}
}
