//
//  NotePresenter.swift
//  Task
//
//  Created by Habib on 14/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import UIKit
import RealmSwift

protocol NoteDelegate {
    func noteAddSucceed()
    func noteAddDidFailedWith(_ message: String)
    func fetchNoteSucceddWith(_ note: Note)
    func fetchNoteDidFailedWith(_ message: String)
    
}

protocol AddNote {
    func addNoteWith(userId id: Int, note: String)
}

class NotePresenter: NSObject, AddNote {
    private var delegate: NoteDelegate
    
    init(delegate: NoteDelegate) {
        self.delegate = delegate
    }
    
    func addNoteWith(userId id: Int, note: String) {
        do {
            let realm = try Realm()
            
            let newNote = Note()
            newNote.userId = id
            newNote.note = note
            
            try realm.write {
                realm.add(newNote)
            }
            delegate.noteAddSucceed()
        }catch (let error) {
            delegate.noteAddDidFailedWith(error.localizedDescription)
        }
    }
    
    func fetchNoteWith(userId id: Int) {
        do {
            guard let note = try Realm()
                .objects(Note.self)
                .filter("userId == 1234")
                .first
                else{
                    delegate.fetchNoteDidFailedWith("There is no note with this User ID: \(id)")
                    return
            }
            delegate.fetchNoteSucceddWith(note)
        }catch (let error) {
            delegate.fetchNoteDidFailedWith(error.localizedDescription)
        }
    }
}
