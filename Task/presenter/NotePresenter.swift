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

protocol NoteAdd {
    func addNoteWith(userId id: Int, note: String)
}

class NotePresenter: NSObject {

}
