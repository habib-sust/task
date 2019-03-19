//
//  HomePresenterTests.swift
//  TaskTests
//
//  Created by Habib on 19/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import XCTest
import Nimble
import Swinject
import SwinjectAutoregistration
@testable import Task
class HomePresenterTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchRepositoriesDidCalledWithError() {
        let expectation = XCTestExpectation(description: "should call delegate method repositoriesDidFailedWith")
        let homePresenter = HomePresenter(delegate: MockHomeViewController(expectation: expectation), networking: MockNetworking(data: nil, error: APIClientError.noData))
        
        waitUntil{done in
            homePresenter.fetchRepositories(from: "endpoint")
            done()
        }
    }
    
    func testFetchRepositoriesDidCalledWithUnformatedData() {
        let expectation = XCTestExpectation(description: "should call delegate method repositoriesDidFailedWith")
        let data = try! JSONSerialization.data(withJSONObject: MockRepository.data, options: .prettyPrinted)
        let presenter = HomePresenter(delegate: MockHomeViewController(expectation: expectation), networking: MockNetworking(data: data, error: nil))
        presenter.fetchRepositories(from: "endpoint")
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchRepositoriesDidCalledWithFormatData() {
        let expectation = XCTestExpectation(description: "should call delegate method repositoriesSucceedWith")
        let data = try! JSONSerialization.data(withJSONObject: MockRepositories.data, options: .prettyPrinted)
        let presenter = HomePresenter(delegate: MockViewControllerWithFormatedData(expectation: expectation), networking: MockNetworking(data: data, error: nil))
        presenter.fetchRepositories(from: "endpoint")
        
        wait(for: [expectation], timeout: 1)
    }
    
}

class MockHomeViewController: HomeDelegate {
    var expectation: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    func startProgress() {}
    
    func hideProgress() {}
    
    func repositoriesSucceedWith(_ repositories: [Repository]) {}
    
    func repositoriesDidFailedWith(_ message: String) {
        print("Error: \(message)")
        self.expectation.fulfill()
    }
    
    func fetchRepositoriesFromCacheSucceedWith(_ repositories: [Repository]) {}
    
    func fetchRepositoriesFromCacheDidFailedWith(_ message: String) {}
}

class MockViewControllerWithFormatedData: HomeDelegate {
    var expectation: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    func startProgress() {}
    func hideProgress() {}
    
    func repositoriesSucceedWith(_ repositories: [Repository]) {
        expectation.fulfill()
    }
    
    func repositoriesDidFailedWith(_ message: String) {}
    func fetchRepositoriesFromCacheSucceedWith(_ repositories: [Repository]) {}
    func fetchRepositoriesFromCacheDidFailedWith(_ message: String) {}
    
    
}
