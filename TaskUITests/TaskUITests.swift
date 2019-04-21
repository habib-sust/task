//
//  TaskUITests.swift
//  TaskUITests
//
//  Created by Habib on 21/4/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import XCTest
import FBSnapshortTestCase
@testable import Task

class TaskUITests: FBSnapshotTestCase {

    override func setUp() {
        super.setup()
        self.recordMode = true
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let homeController = HomeViewController()
        FBSnapshotVerifyView(homeController.view)
        print("Hello")
    }


}
