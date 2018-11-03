//
//  DataManager.swift
//  Drama
//
//  Created by Ryan on 2018/11/3.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import Foundation

struct DataManager {}

extension DataManager {
	static func dramas(with callback: @escaping (_ dramas: [DramaModel]?, _ error: Error?)->()) {
		APIClient.fetchDramas { (data, error) in
			if let error = error {
				callback(nil, error)
				return
			}
			
			if let data = data {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				do {
					let response = try decoder.decode(responseModel<DramaModel>.self, from: data)
					callback(response.data, nil)
				} catch {
					callback(nil, error)
				}
			}
		}
	}
}
