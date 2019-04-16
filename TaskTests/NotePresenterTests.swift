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
@testable import Task

class NotePresenterTests: XCTestCase {
    let container = Container()
    override func setUp() {
        super.setUp()
        container.register(MockNoteViewController.self) {_ in
           return MockNoteViewController()
        }
        container.register(MockNoteViewControllerForEdit.self) { _ in
            return MockNoteViewControllerForEdit()
        }
    }
    
    override func tearDown() {
        super.setUp()
        container.removeAll()
    }
    
    func testAddNoteSuccedWithUserIdAndNote() {
        let delegate = container.resolve(MockNoteViewController.self)!
        let presenter = NotePresenter(delegate: delegate)
        presenter.addNoteWith(userId: 1, note: "abc")
        
        expect(delegate.addNoteSucced).toEventually(beTrue(), description: "should call delegate method addNoteSucced")
    }
    
    func testFetchNoteSucceedWithUserId(){
        let delegate = container.resolve(MockNoteViewController.self)!
        let presenter = NotePresenter(delegate: delegate)
        presenter.fetchNoteWith(userId: 1)
        
        expect(delegate.fetchNoteSucceedWith).to(beTrue(), description: "should call delegate method fetchNoteSucceedWith")
    }
    
    func testFetchNoteDidFailedWithWrongUserId(){
        let delegate = container.resolve(MockNoteViewController.self)!
        let presenter = NotePresenter(delegate: delegate)
        presenter.fetchNoteWith(userId: 123)
        
        expect(delegate.fetchNoteDidFailedWith).to(beTrue(), description: "should call delegate method fetchNoteDidFailedWith")
    }
    
    func testEditNoteWithWrongUserId() {
        let delegate = container.resolve(MockNoteViewControllerForEdit.self)!
        let presenter = NotePresenter(delegate: delegate)
        presenter.editNoteWith(userId: 07, newNote: "new note")
        
        expect(delegate.editNoteDidFailed).to(beTrue(), description: "shoud call delegate method addOrEditNoteDidFailedWith")
        
    }
    
    func testEditNoteWithVaildUserId() {
        let delegate = container.resolve(MockNoteViewControllerForEdit.self)!
        let presenter = NotePresenter(delegate: delegate)
        presenter.editNoteWith(userId: 1, newNote: "new note")
    
        expect(delegate.editNoteSucced).to(beTrue(), description: "should call delegate method addOrEditNoteSucced")
    }
    
    func testDidchangeCurrentNoteWithExtraSpace() {
        let delegate = container.resolve(MockNoteViewControllerForEdit.self)!
        let presenter = NotePresenter(delegate: delegate)
        
        expect(presenter.didChangeNote(saveNote: "abc ", currentNote: "abc")).to(beFalse(), description: "should return false")
        
    }
    
    func testDidChangeCurrentNoteWithDifferentValue () {
        let delegate = container.resolve(MockNoteViewControllerForEdit.self)!
        let presenter = NotePresenter(delegate: delegate)
        
        expect(presenter.didChangeNote(saveNote: "abc", currentNote: "abcdef")).to(beTrue(), description: "should return true")
    }
    
    func testDidChangeCurrentNoteWithSameValue() {
        let delegate = container.resolve(MockNoteViewControllerForEdit.self)!
        let presenter = NotePresenter(delegate: delegate)
        
        expect(presenter.didChangeNote(saveNote: "abc", currentNote: "abc")).to(beFalse(), description: "should return false")
    }
}

class MockNoteViewController: NoteViewable {
    var addNoteSucced = false
    var fetchNoteSucceedWith = false
    var fetchNoteDidFailedWith = false
    
    func addOrEditNoteDidFailedWith(_ message: String) {}
    func addOrEditNoteSucceed() {
        addNoteSucced = true
    }
    
    func fetchNoteSucceddWith(_ note: Note) {
        fetchNoteSucceedWith = true
    }
    
    func fetchNoteDidFailedWith(_ message: String) {
        fetchNoteDidFailedWith = true
    }
}

class MockNoteViewControllerForEdit: NoteViewable {
    var editNoteSucced = false
    var editNoteDidFailed = false
    
    func addOrEditNoteSucceed() {
        editNoteSucced = true
    }
    
    func addOrEditNoteDidFailedWith(_ message: String) {
        editNoteDidFailed = true
    }
    
    func fetchNoteSucceddWith(_ note: Note) {}
    
    func fetchNoteDidFailedWith(_ message: String) {}
}
