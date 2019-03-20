//
//  TaskTests.swift
//  TaskTests
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import XCTest
import Nimble
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
        expect(owner.ownerName).to(equal("facebook"))
        expect(owner.avatarURL).to(equal("avatar url"))
    }
    
    func testRepositoryModel() {
        let repository = container ~> (Repository.self)
        expect(repository.id).to(equal(1))
        expect(repository.description).to(equal("description"))
    }

}
