//
//  TaskTests.swift
//  TaskTests
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import XCTest
import Swinject
import SwinjectAutoregistration


@testable import Task

extension Owner {
    init(name: String) {
        self.init(name: name)
    }
}

extension Repository {
    init(owner: Owner) {
        self.init(owner: owner)
    }
}
class TaskTests: XCTestCase {
    let container = Container()
    override func setUp() {
        container.autoregister(Owner.self,
                               argument: String.self,
                               initializer:  Owner.init(name: ))
        
        container.autoregister(Repository.self,
                               argument: Owner.self, initializer: Repository.init(owner: ))
    }

    override func tearDown() {
        container.removeAll()
    }

    func testOwnerModel() {
        let owner = container ~> (Owner.self, argument: "name")
        XCTAssertEqual(owner.ownerName, "name")
    }
    
    func testRepositoryModel() {
        let owner = container ~> (Owner.self, argument: "name")
        let repository = container ~> (Repository.self, argument: owner)
        
        XCTAssertEqual(repository.owner?.ownerName, "name")
    }

}
