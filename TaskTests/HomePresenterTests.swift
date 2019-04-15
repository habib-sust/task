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
        
        container.register(MockNetworking.self, name: "noData") {_ in
            let networking = MockNetworking(data: nil, error: APIClientError.noData)
            return networking
        }
        
        container.register(MockNetworking.self){ _ in
            let data = try! JSONSerialization.data(withJSONObject: MockRepository.data, options: .prettyPrinted)
            let networking = MockNetworking(data: data, error: nil)
            return networking
        }
        
        container.register(MockNetworking.self, name: "formatData") {_ in
            let data = try! JSONSerialization.data(withJSONObject: MockRepositories.data, options: .prettyPrinted)
            let networking = MockNetworking(data: data, error: nil)
            return networking
        }
    }

    override func tearDown() {
        super.tearDown()
        container.removeAll()
    }
    
    func testRepositoriesDidFailedWithError() {
        let delegate = container.resolve(MockHomeViewController.self)!
        let networking = container.resolve(MockNetworking.self, name: "noData")!
        let presenter = HomePresenter(delegate: delegate, networking: networking)
        presenter.fetchRepositories(from: "endpoint")
        
        expect(delegate.testFetchRepositoriesDidCalledWithError)
            .toEventually(beTrue(), description: "should call delegate method repositoriesDidFailedWith")
    }
    
    func testRepositoriesDidFailedWithUnformatedData() {
        let delegate = container.resolve(MockHomeViewControllerWithFormatedData.self)!
        let networking = container.resolve(MockNetworking.self)!
        let presenter = HomePresenter(delegate: delegate, networking: networking)
        presenter.fetchRepositories(from: "endpoint")
        
        expect(delegate.testFetchRepositoriesDidCalledWithUnformatedData)
            .toEventually( beTrue(), description: "should call delegate method repositoriesDidFailedWith")
    }
    
    func testRepositoriesSucceedWithFormatData() {
        let delegate = container.resolve(MockHomeViewController.self)!
        let networking = container.resolve(MockNetworking.self, name: "formatData")!
        let presenter = HomePresenter(delegate: delegate, networking: networking)
        presenter.fetchRepositories(from: "endpoint")
        
        expect(delegate.testFetchRepositoriesDidCalledWithFormatData)
            .toEventually(beTrue(), description: "should call delegate method repositoriesSucceedWith")
    }
    
    func testStartProgressDidCalled() {
        let delegate = container.resolve(MockHomeViewController.self)!
        let networking = container.resolve(MockNetworking.self, name: "noData")!
        let presenter = HomePresenter(delegate: delegate, networking: networking)
        presenter.fetchRepositories(from: "endpoint")
        
        expect(delegate.testStartProgressDidCalled)
            .toEventually(beTrue(), description: "should call delegate method startProgress")
        
    }
    
    func testHidePregressDidCalledWithError() {
        let delegate = container.resolve(MockHomeViewController.self)!
        let netwoking = container.resolve(MockNetworking.self, name: "noData")!
        let presenter = HomePresenter(delegate: delegate, networking: netwoking)
        presenter.fetchRepositories(from: "endpoint")
        
        expect(delegate.testHidePregressDidCalled)
            .toEventually(beTrue(), description: "should call delegate method hideProgress")
    }
    
    func testHideProgressWithFormatData() {
        let delegate = container.resolve(MockHomeViewControllerWithFormatedData.self)!
        let networking = container.resolve(MockNetworking.self, name: "formatData")!
        let presenter = HomePresenter(delegate: delegate, networking: networking)
        presenter.fetchRepositories(from: "endpoint")
        
        expect(delegate.testHideProgressWithFormatData)
            .toEventually(beTrue(), description: "should call delegate method hideProgress")
    }
    
    func testFetchRepositoriesFromCacheDidFailedWithEmptyURL() {
        let delegate = container.resolve(MockHomeViewController.self)!
        let networking = container.resolve(MockNetworking.self)!
        let presenter = HomePresenter(delegate: delegate, networking: networking)
        presenter.fetchRepositoriesFromCache(with: "")
        
        expect(delegate.testFetchRepositoriesFromCacheDidFailedWith)
            .toEventually(beTrue(), description: "should call delegate method fetchRepositoriesfromCacheDidFailedWith")
    }
    
    func testFetchRepositoriesFromCacheSucceedWithValidURL() {
        let delegate = container.resolve(MockHomeViewController.self)!
        let networking = container.resolve(MockNetworking.self)!
        let presenter = HomePresenter(delegate: delegate, networking: networking)
        presenter.fetchRepositoriesFromCache(with: Constants.baseURL)
        
        expect(delegate.testFetchRepositoriesFromCacheSucceedWithDidCalled)
            .toEventually(beFalse(), description: "should call delegate method fetchRepositoriesfromCacheWithSucceed")
        
    }
}

class MockHomeViewController: HomeViewable {
    var testFetchRepositoriesDidCalledWithError = false
    var testFetchRepositoriesDidCalledWithFormatData = false
    var testStartProgressDidCalled = false
    var testHidePregressDidCalled = false
    var testFetchRepositoriesFromCacheSucceedWithDidCalled = false
    var testFetchRepositoriesFromCacheDidFailedWith = false
    
    func startProgress() {
        testStartProgressDidCalled = true
    }
    
    func hideProgress() {
        testHidePregressDidCalled = true
    }
    
    func fetchRepositoriesFromCacheSucceedWith(_ repositories: [Repository]) {
        testFetchRepositoriesFromCacheSucceedWithDidCalled = true
    }
    
    func fetchRepositoriesFromCacheDidFailedWith(_ message: String) {
        testFetchRepositoriesFromCacheDidFailedWith = true
    }
    
    func repositoriesSucceedWith(_ repositories: [Repository]) {
        testFetchRepositoriesDidCalledWithFormatData = true
    }
    
    func repositoriesDidFailedWith(_ message: String) {
        testFetchRepositoriesDidCalledWithError = true
    }
}

class MockHomeViewControllerWithFormatedData: HomeViewable {
    var testFetchRepositoriesDidCalledWithUnformatedData = false
    var testHideProgressWithFormatData = false
    
    func startProgress() {}
    func hideProgress() {
        testHideProgressWithFormatData = true
    }
    func fetchRepositoriesFromCacheSucceedWith(_ repositories: [Repository]) {}
    func fetchRepositoriesFromCacheDidFailedWith(_ message: String) {}
    func repositoriesSucceedWith(_ repositories: [Repository]) {}
    
    func repositoriesDidFailedWith(_ message: String) {
        testFetchRepositoriesDidCalledWithUnformatedData = true
    }
    
}
