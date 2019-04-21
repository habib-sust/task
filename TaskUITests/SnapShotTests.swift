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
        self.recordMode = true
    }
    
//    override func recordFailure(withDescription description: String, inFile filePath: String, atLine lineNumber: Int, expected: Bool) {
//        let imageData = app.screenshot().image.pngData()
//
//        if let path = failureImageDirectoryPath?
//            .appendingPathComponent("/")
//            .appendingPathComponent("\(self)_\(lineNumber)") {
//
//            try? imageData?.write(to: path)
//        }
//
//        super.recordFailure(withDescription: description, inFile: filePath, atLine: lineNumber, expected: expected)
//    }
//
//    private var failureImageDirectoryPath: URL? {
//        let fileManager = FileManager.default
//        guard let pathString = ProcessInfo.processInfo.environment["FAILED_UI_TEST_DIR"] else {
//            return nil
//        }
//
//        let path = URL(fileURLWithPath: pathString)
//        if !fileManager.fileExists(atPath: path.absoluteString) {
//            try? fileManager.createDirectory(
//                at: path,
//                withIntermediateDirectories: true,
//                attributes: nil
//            )
//        }
//        return path
//    }
    
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
