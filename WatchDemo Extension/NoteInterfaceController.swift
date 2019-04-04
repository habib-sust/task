//
//  NoteInterfaceController.swift
//  WatchDemo Extension
//
//  Created by Habib on 3/4/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import WatchKit
import Foundation

class NoteInterfaceController: WKInterfaceController {
    @IBOutlet weak var noteLabel: WKInterfaceLabel!
    private let connectivityHandler = WatchSessionManger.shared
    private var presenter: NotePresenter?
    private var userId: Int!
    private var note: String? {
        didSet{
            setNote()
        }
    }
    
    //MARK: LifeCyle
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        presenter = NotePresenter(delegate: self)
        
        if let receivedUserId = context as? Int {
            userId = receivedUserId
            return
        }
        
        if let noteInfo = context as? [Any] {
            note = noteInfo[0] as? String
            userId = noteInfo[1] as? Int
        }
    }

    override func willActivate() {
        super.willActivate()
        connectivityHandler.watchOSDelegate = self
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    //MARK: Private Methods
    private func setNote() {
        noteLabel.setText(note)
    }
    
    private func addNote() {
        if let note = note {
            presenter?.addNoteWith(userId: userId, note: note)
        }
    }
    
    private func fetchNote() {
        presenter?.fetchNoteWith(userId: userId)
    }
    
    private func editNote() {
        if let newNote = note {
            presenter?.editNoteWith(userId: userId, newNote: newNote)
        }
    }
}

// MARK: - WatchOSDelegate
extension NoteInterfaceController: WatchOSDelegate {
    func messageReceived(tuple: MessageReceived) {
        if let noteInfo = tuple.message["noteInfo"] as? [Any] {
            note = noteInfo[0] as? String
            userId = noteInfo[1] as? Int
            editNote()
        }
    }
}


//MARK: - NoteViewable Delegate
extension NoteInterfaceController: NoteViewable {
    func addOrEditNoteSucceed() {
        print("addOrEditNoteSucceed")
    }
    
    func addOrEditNoteDidFailedWith(_ message: String) {
        print("addOrEditNoteDidFailedWith: \(message)")
        
    }
    
    func fetchNoteSucceddWith(_ note: Note) {
        self.note = note.note
    }
    
    func fetchNoteDidFailedWith(_ message: String) {
        print("fetchNoteDidFailedWith: \(message)")
        let errorMessage = "There is no note with this User ID: \(userId ?? 0)"
        print("Error Message: \(errorMessage)")
        if message == errorMessage {
            addNote()
        }
    }
}
