//
//  NotePresenterTests.swift
//  
//
//  Created by Habib on 19/3/19.
//

import XCTest
@testable import Task

class NotePresenterTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.setUp()
    }

    func testAddNoteWithUserIdAndNote() {
        let expectation = XCTestExpectation(description: "should call delegate method addNoteSucced")
        let presenter = NotePresenter(delegate: MockNoteViewController(expectation: expectation))
        presenter.addNoteWith(userId: 1, note: "")
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchNoteWithUserId(){
        let expectation = XCTestExpectation(description: "should call delegate method fetchNoteWithSucceed")
        let presenter = NotePresenter(delegate: MockNoteViewControllerFetchNote(expectation: expectation))
        presenter.fetchNoteWith(userId: 1)
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchNoteWithWrongUserId(){
        let expectation = XCTestExpectation(description: "should call delegate method fetchNoteDidFailedWith")
        let presenter = NotePresenter(delegate: MockNoteViewController(expectation: expectation))
        presenter.fetchNoteWith(userId: 123)
        wait(for: [expectation], timeout: 1)
    }
    
}

class MockNoteViewController: NoteDelegate {
    var expectation: XCTestExpectation
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    func addNoteSucceed() {
        expectation.fulfill()
    }
    
    func addNoteDidFailedWith(_ message: String) {}
    func fetchNoteSucceddWith(_ note: Note) {}
    
    func fetchNoteDidFailedWith(_ message: String) {
        XCTAssertEqual(message, "There is no note with this User ID: 123")
        expectation.fulfill()
    }
}

class MockNoteViewControllerFetchNote: NoteDelegate {
    var expectation: XCTestExpectation
    init(expectation: XCTestExpectation){
        self.expectation = expectation
    }
    
    func addNoteSucceed() {}
    
    func addNoteDidFailedWith(_ message: String) {}
    
    func fetchNoteSucceddWith(_ note: Note) {
        XCTAssertEqual(note.userId, 1)
        expectation.fulfill()
    }
    
    func fetchNoteDidFailedWith(_ message: String) {
        
    }
}

