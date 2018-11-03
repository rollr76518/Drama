//
//  DramaModel.swift
//  Drama
//
//  Created by Ryan on 2018/11/3.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import Foundation

struct DramaModel {
	var id: String
	var name: String
	var totalViews: Int
	var createdAt: Date
	var thumbURL: String
	var rating: Float
}

extension DramaModel: Decodable {
	enum CodingKeys: String, CodingKey {
		case name, totalViews, createdAt, rating
		case id = "dramaId"
		case thumbURL = "thumb"
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeStringFromInt(Int.self, forKey: .id)
		name = try values.decode(String.self, forKey: .name)
		totalViews = try values.decode(Int.self, forKey: .totalViews)
		createdAt = try values.decodeDateFromString(String.self, forKey: .createdAt)
		thumbURL = try values.decode(String.self, forKey: .thumbURL)
		rating = try values.decode(Float.self, forKey: .rating)
	}
}
