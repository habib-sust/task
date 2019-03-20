//
//  NotePresenterTests.swift
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

class NotePresenterTests: XCTestCase {
    let container = Container()
    override func setUp() {
        super.setUp()
        
        container.register(MockNoteViewController.self) {_ in
            MockNoteViewController()
        }
    }
    
    override func tearDown() {
        super.setUp()
        container.removeAll()
    }
    
    func testAddNoteSuccedWithUserIdAndNote() {
        let delegate = container ~> (MockNoteViewController.self)
        let presenter = NotePresenter(delegate: delegate)
        presenter.addNoteWith(userId: 1, note: "abc")
        
        expect(delegate.addNoteSucced).toEventually(beTrue(), description: "should call delegate method addNoteSucced")
    }
    
    func testFetchNoteSucceedWithUserId(){
        let delegate = container ~> (MockNoteViewController.self)
        let presenter = NotePresenter(delegate: delegate)
        presenter.fetchNoteWith(userId: 1)
        expect(delegate.fetchNoteSucceedWith).to(beTrue(), description: "should call delegate method fetchNoteSucceedWith")
    }
    
    func testFetchNoteDidFailedWithWrongUserId(){
        let delegate = container ~> (MockNoteViewController.self)
        let presenter = NotePresenter(delegate: delegate)
        presenter.fetchNoteWith(userId: 123)
        expect(delegate.fetchNoteDidFailedWith).to(beTrue(), description: "should call delegate method fetchNoteDidFailedWith")
    }
    
}

class MockNoteViewController: NoteDelegate {
    var addNoteSucced = false
    var fetchNoteSucceedWith = false
    var fetchNoteDidFailedWith = false
    
    func addNoteSucceed() {
        addNoteSucced = true
    }
    
    func addNoteDidFailedWith(_ message: String) {}
    func fetchNoteSucceddWith(_ note: Note) {
        fetchNoteSucceedWith = true
    }
    
    func fetchNoteDidFailedWith(_ message: String) {
        fetchNoteDidFailedWith = true
    }
}
