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
	var thumbURL: URL
	var rating: Float
}

extension DramaModel: Codable {
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
		thumbURL = try values.decodeURLFromString(String.self, forKey: .thumbURL)
		rating = try values.decode(Float.self, forKey: .rating)
	}
	
	func encode(to encoder: Encoder) throws {
		do {
			var values = encoder.container(keyedBy: CodingKeys.self)
			try values.encodeIntFromString(id, forKey: .id)
			try values.encode(name, forKey: .name)
			try values.encode(totalViews, forKey: .totalViews)
			try values.encodeStringFromDate(createdAt, forKey: .createdAt)
			try values.encodeStringFromURL(thumbURL, forKey: .thumbURL)
			try values.encode(rating, forKey: .rating)
		} catch {
			throw error
		}
	}

}
