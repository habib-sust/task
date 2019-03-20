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
    let container = Container()
    
    override func setUp() {
        super.setUp()
        container.register(MockHomeViewController.self) {_ in
            return MockHomeViewController()
        }
        
        container.register(MockHomeViewControllerWithFormatedData.self) {_ in
            MockHomeViewControllerWithFormatedData()
        }
        
        container.register(MockNetworking.self){ _ in
            let data = try! JSONSerialization.data(withJSONObject: MockRepository.data, options: .prettyPrinted)
            let networking = MockNetworking(data: data, error: nil)
            
            return networking
        }
    }

    override func tearDown() {
        super.tearDown()
        container.removeAll()
    }
    
    func testFetchRepositoriesDidCalledWithError() {
        let delegate = container ~> (MockHomeViewController.self)
        let homePresenter = HomePresenter(delegate: delegate, networking: MockNetworking(data: nil, error: APIClientError.noData))
        homePresenter.fetchRepositories(from: "endpoint")
        
        expect(delegate.testFetchRepositoriesDidCalledWithError)
            .toEventually(beTrue(), description: "should call delegate method repositoriesDidFailedWith")
    }
    
    func testFetchRepositoriesDidCalledWithUnformatedData() {
        let delegate = container ~> (MockHomeViewControllerWithFormatedData.self)
        let networking = container ~> (MockNetworking.self)
        let presenter = HomePresenter(delegate: delegate, networking: networking)
        presenter.fetchRepositories(from: "endpoint")
        
        expect(delegate.testFetchRepositoriesDidCalledWithUnformatedData)
            .toEventually( beTrue(), description: "should call delegate method repositoriesDidFailedWith")
    }
    
    func testFetchRepositoriesDidCalledWithFormatData() {
        let delegate = container ~> (MockHomeViewController.self)
        let data = try! JSONSerialization.data(withJSONObject: MockRepositories.data, options: .prettyPrinted)
        let networking = MockNetworking(data: data, error: nil)
        let presenter = HomePresenter(delegate: delegate, networking: networking)
        presenter.fetchRepositories(from: "endpoint")
        
        expect(delegate.testFetchRepositoriesDidCalledWithFormatData)
            .toEventually(beTrue(), description: "should call delegate method repositoriesSucceedWith")
    }
    
}

class MockHomeViewController: HomeDelegate {
    var testFetchRepositoriesDidCalledWithError = false
    var testFetchRepositoriesDidCalledWithFormatData = false
    func startProgress() {}
    func hideProgress() {}
    func fetchRepositoriesFromCacheSucceedWith(_ repositories: [Repository]) {}
    func fetchRepositoriesFromCacheDidFailedWith(_ message: String) {}
    
    func repositoriesSucceedWith(_ repositories: [Repository]) {
        testFetchRepositoriesDidCalledWithFormatData = true
    }
    
    func repositoriesDidFailedWith(_ message: String) {
        testFetchRepositoriesDidCalledWithError = true
    }
}

class MockHomeViewControllerWithFormatedData: HomeDelegate {
    var testFetchRepositoriesDidCalledWithUnformatedData = false
    func startProgress() {}
    func hideProgress() {}
    func fetchRepositoriesFromCacheSucceedWith(_ repositories: [Repository]) {}
    func fetchRepositoriesFromCacheDidFailedWith(_ message: String) {}
    func repositoriesSucceedWith(_ repositories: [Repository]) {}
    
    func repositoriesDidFailedWith(_ message: String) {
        testFetchRepositoriesDidCalledWithUnformatedData = true
    }

    
    
}
