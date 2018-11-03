//
//  KeyedDecodingContainer+Extension.swift
//  Drama
//
//  Created by Ryan on 2018/11/3.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
	func decodeDateFromString(_ type: String.Type, forKey key: KeyedDecodingContainer.Key) throws -> Date {
		do {
			let string = try decode(String.self, forKey: key)
			
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
			//"2017-12-02T03:34:41.000Z"
			
			let date = dateFormatter.date(from: string)
			
			//TODO: should handle by error report
			return date ?? Date()
		} catch  {
			throw error
		}
	}
	
	func decodeStringFromInt(_ type: Int.Type, forKey key: KeyedDecodingContainer.Key) throws -> String {
		do {
			let int = try decode(Int.self, forKey: key)
			
			return "\(int)"
		} catch {
			throw error
		}
	}
}
