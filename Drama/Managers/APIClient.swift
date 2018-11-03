//
//  APIClient.swift
//  Drama
//
//  Created by Ryan on 2018/11/3.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import Foundation

struct APIClient {}

extension APIClient {
	static func fetchDramas(with callback: @escaping (_ data: Data?, _ error: Error?)->()) {
		guard let url = URL(string: "http://www.mocky.io/v2/5a97c59c30000047005c1ed2") else { return  }
		
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		
		let task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: request) { (data, response, error) in
			callback(data, error)
		}
		
		task.resume()
	}
}
