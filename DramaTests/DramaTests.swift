//
//  DramaTests.swift
//  DramaTests
//
//  Created by Ryan on 2018/11/3.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import XCTest
@testable import Drama

class DramaTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testFetchDramas() {
		let expectation = XCTestExpectation(description: "Testing APIClient Fetch Dramas callback")
		
		APIClient.fetchDramas { (data, error) in
			if let error = error {
				print(error)
				assertionFailure("Testing APIClient Fetch Dramas error reason: \(error.localizedDescription)")
				expectation.fulfill()
			}
			
			if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
				print(json)
				expectation.fulfill()
			}
		}
		
		wait(for: [expectation], timeout: 5)
	}

	func testDataDramas() {
		let expectation = XCTestExpectation(description: "Testing DataManager dramas callback")
		
		DataManager.dramas { (status) in
			switch status {
			case .success(let dramas):
				print(dramas)
				expectation.fulfill()
			case .failure(let error):
				print(error)
				assertionFailure("Testing DataManager dramas error reason: \(error.localizedDescription)")
				expectation.fulfill()
			}
		}

		wait(for: [expectation], timeout: 5)
	}
}
