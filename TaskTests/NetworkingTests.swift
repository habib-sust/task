//
//  NetworkingTests.swift
//  TaskTests
//
//  Created by Habibur Rahman on 18/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import XCTest
import Swinject
@testable import Task
class NetworkingTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

struct MockNetworking: NetWorking {
    var data: Data?
    var error: Error?
    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }
    func get(from endPoint: String, completion: @escaping completionHandler) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        if let repos = repos {
            completion(.success(data))
        }
    }
    
    
}
