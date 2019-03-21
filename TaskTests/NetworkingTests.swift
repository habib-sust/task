//
//  NetworkingTests.swift
//  TaskTests
//
//  Created by Habibur Rahman on 18/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Swinject
@testable import Task

class NetworkingTests: XCTestCase {
    let container = Container()
    
    override func setUp() {
        container.register(Networking.self) { _ in
            let data = try! JSONSerialization.data(withJSONObject: MockRepository.data, options: JSONSerialization.WritingOptions.prettyPrinted)
            let networking = MockNetworking(data: data, error: nil)
            return networking
        }
    }

    override func tearDown() {
        container.removeAll()
    }

    func testNetworkingWithMockData() {
        let networking = container.resolve(Networking.self)
        let expectation = XCTestExpectation(description: "should get mockrepository data")
        
        
        networking?.get(from: Constants.baseURL, onCompletion: { result in
            switch result {
            case .onSuccess(let data):
                expect(data).notTo(beNil())
                expectation.fulfill()
            default :
                XCTFail()
            }
        })
        wait(for: [expectation], timeout: 1.0)
    }
}

struct MockNetworking: Networking {
    var data: Data?
    var error: Error?
    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }
    
    func get(from endPoint: String, onCompletion: @escaping completionHandler) {
        if let error = error {
            onCompletion(.onFailure(error))
            return
        }
        
        if let data = data {
            onCompletion(.onSuccess(data))
        }
    }
}
