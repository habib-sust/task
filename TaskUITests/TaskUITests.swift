//
//  TaskUITests.swift
//  TaskUITests
//
//  Created by Habib on 7/4/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import XCTest

class TaskUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
        app.terminate()
    }

    
    func testSendButton() {
        let sendButton = app.navigationBars["Task.HomeView"].buttons["Send"]
        XCTAssertTrue(sendButton.exists)
    }

    func testEditButton() {
        app.tables.cells.element(boundBy: 0).tap()
        app.navigationBars["Task.NoteView"].buttons["Edit"].tap()
        app.otherElements.containing(.navigationBar, identifier:"Task.NoteView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element.tap()
        
        app.otherElements.containing(.navigationBar, identifier:"Task.NoteView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element.typeText(" hello world")

    }
}
