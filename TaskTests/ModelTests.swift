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

class ModelTests: XCTestCase {
    let container = Container()
    override func setUp() {
        container.register(Owner.self){_ in
            let data = try! JSONSerialization.data(withJSONObject: MockOwner.data, options: JSONSerialization.WritingOptions.prettyPrinted)
            let owner = try! JSONDecoder().decode(Owner.self, from: data)
            return owner
        }
        
        container.register(Owner.self){_ in
            let data = try! JSONSerialization.data(withJSONObject: MockOwner.data, options: JSONSerialization.WritingOptions.prettyPrinted)
            let owner = try! JSONDecoder().decode(Owner.self, from: data)
            return owner
        }
        
        container.register(Repository.self){_ in
            let data = try! JSONSerialization.data(withJSONObject: MockRepository.data, options: JSONSerialization.WritingOptions.prettyPrinted)
            let repository = try! JSONDecoder().decode(Repository.self, from: data)
            return repository
        }
    }

    override func tearDown() {
        container.removeAll()
    }

    func testOwnerModel() {
        let owner = container ~> (Owner.self)
        XCTAssertEqual(owner.ownerName, "facebook")
        XCTAssertEqual(owner.avatarURL, "avatar url")
    }
    
    func testRepositoryModel() {
        let repository = container ~> (Repository.self)
        XCTAssertEqual(repository.id, 1)
        XCTAssertEqual(repository.description, "description")
    }

}
