//
//  NotePresenter.swift
//  Task
//
//  Created by Habib on 14/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import UIKit
import RealmSwift

protocol NoteViewable: AnyObject {
    func addOrEditNoteSucceed()
    func addOrEditNoteDidFailedWith(_ message: String)
    func fetchNoteSucceddWith(_ note: Note)
    func fetchNoteDidFailedWith(_ message: String)
}

protocol NoteAddable {
    func addNoteWith(userId id: Int, note: String)
}

protocol NoteFetchable {
    func fetchNoteWith(userId id: Int)
}

protocol NoteEditable {
    func editNoteWith(userId: Int, newNote: String)
}

struct NotePresenter: NoteAddable, NoteFetchable, NoteEditable {
    private weak var delegate: NoteViewable?
    
    init(delegate: NoteViewable) {
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
            delegate?.addOrEditNoteSucceed()
        }catch (let error) {
            delegate?.addOrEditNoteDidFailedWith(error.localizedDescription)
        }
    }
    
    func fetchNoteWith(userId id: Int) {
        do {
            guard let note = try fetchNote(userID: id) else{
                    delegate?.fetchNoteDidFailedWith("There is no note with this User ID: \(id)")
                    return
            }
            delegate?.fetchNoteSucceddWith(note)
        }catch (let error) {
            delegate?.fetchNoteDidFailedWith(error.localizedDescription)
        }
    }
    
    func editNoteWith(userId: Int, newNote: String) {
        do {
            guard let note = try fetchNote(userID: userId) else {
                delegate?.addOrEditNoteDidFailedWith("There is no note with this User ID: \(userId)")
                return
            }
            
            try Realm().write {
                note.note = newNote
            }
            delegate?.addOrEditNoteSucceed()
            
        } catch (let error) {
            delegate?.addOrEditNoteDidFailedWith(error.localizedDescription)
        }
    }
    

    private func fetchNote(userID: Int) throws -> Note?{
        let note = try Realm()
        .objects(Note.self)
        .filter("userId == %d", userID)
        .first
        
        return note
    }
    
}
