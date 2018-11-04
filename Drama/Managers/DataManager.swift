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
	enum GetDramasStatus {
		case success([DramaModel])
		case failure(Error)
	}
	
	static func dramas(with callback: @escaping (_ status: GetDramasStatus)->()) {
		if InternetStatus.isConnectedToNetwork() {
			APIClient.fetchDramas { (data, error) in
				if let error = error {
					callback(.failure(error))
					return
				}
				
				if let data = data {
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase
					do {
						let response = try decoder.decode(ResponseModel<DramaModel>.self, from: data)
						let dramas = response.data
						try DataManager.save(dramas, key: Notification.Name.kLocalDramas.rawValue)
						
						callback(.success(dramas))
					} catch {
						callback(.failure(error))
					}
				}
			}
		} else {
			do {
				let dramas = try DataManager.loadLocal(DramaModel.self, key: Notification.Name.kLocalDramas.rawValue)
				callback(.success(dramas))
			} catch {
				callback(.failure(error))
			}
		}
	}
}

extension DataManager {
	static func save<T: Codable>(_ models: [T], key: String) throws {
		do {
			let encoder = JSONEncoder()
			encoder.keyEncodingStrategy = .convertToSnakeCase
			let data = try encoder.encode(models)
			UserDefaults.standard.set(data, forKey: key)
		} catch {
			throw error
		}
	}
	
	static func loadLocal<T: Codable>(_ type: T.Type, key: String) throws -> [T] {
		do {
			if let data = UserDefaults.standard.data(forKey: key) {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let models = try decoder.decode([T].self, from: data)
				return models
			} else {
				return [T]()
			}
		} catch {
			throw error
		}
	}
}
