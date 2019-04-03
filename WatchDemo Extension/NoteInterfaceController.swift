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
    private var presenter: NotePresenter?
    private let connectivityHandler = WatchSessionManger.shared
    
    var note: String? {
        didSet{
            setNote()
        }
    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let receivedNote = context as? String {
            note = receivedNote
        }
    }

    override func willActivate() {
        super.willActivate()
        connectivityHandler.watchOSDelegate = self
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    private func setNote() {
        noteLabel.setText(note)
    }

}


extension NoteInterfaceController: WatchOSDelegate {
    func messageReceived(tuple: MessageReceived) {
        if let note = tuple.message["note"] as? String {
            self.note = note
        }
    }
    
    
}
