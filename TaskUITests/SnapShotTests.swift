//
//  SnapShotTests.swift
//  Task
//
//  Created by Habib on 21/4/19.
//  Copyright © 2019 Habib. All rights reserved.
//
import UIKit
import FBSnapshotTestCase
@testable import Task

class SnapShotTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        self.recordMode = false
    }
    
    func testExample() {
        
        let homeController = HomeViewController()
        _ = homeController.view
        sleep(6)
        
        FBSnapshotVerifyView(homeController.view)
        
    }
    
    func testNoteView() {
        let noteController = NoteViewController()
        noteController.userId = 455600
        _ = noteController.view
        FBSnapshotVerifyView(noteController.view)
    }

}
