//
//  KeyedEncodingContainer+Extension.swift
//  Drama
//
//  Created by Ryan on 2018/11/4.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import Foundation

extension KeyedEncodingContainer {
	public mutating func encodeStringFromDate(_ value: Date, forKey key: KeyedEncodingContainer<K>.Key) throws {
		do {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
			//"2017-12-02T03:34:41.000Z"
			let string = dateFormatter.string(from: value)
			
			try encode(string, forKey: key)
		} catch {
			throw error
		}
	}
	
	public mutating func encodeIntFromString(_ value: String, forKey key: KeyedEncodingContainer<K>.Key) throws {
		do {
			let int: Int = Int(value) ?? 0
			
			try encode(int, forKey: key)
		} catch {
			throw error
		}
	}

	public mutating func encodeStringFromURL(_ value: URL, forKey key: KeyedEncodingContainer<K>.Key) throws {
		do {
			let string = value.absoluteString
			
			try encode(string, forKey: key)
		} catch {
			throw error
		}
	}
}
