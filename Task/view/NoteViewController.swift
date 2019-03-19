//
//  NoteViewController.swift
//  Task
//
//  Created by Habib on 14/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    
    //***** MARK: - Views *****
    private var noteTextView = UITextView()
    private var presenter: NotePresenter?
    
    //*****MARK:- Properties *****
    var userId: Int?
    
    //*****MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        presenter = NotePresenter(delegate: self)
        fetchNote()
    }

    //***** MARK: - Private Methods *****
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(noteTextView)
        noteTextView.font = UIFont(name: "Avenir", size: 14)
        noteTextView.isEditable = false
    }
    
    private func addNavigationItem() {
        noteTextView.isEditable = true
        let saveNoteButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveNoteButton(sender:)))
        navigationItem.rightBarButtonItems = [saveNoteButton]
    }
    
    private func setupConstraints() {
        noteTextView.anchor(top: view.topAnchor,
                            left: view.readableContentGuide.leftAnchor,
                            bottom: view.bottomAnchor,
                            right: view.readableContentGuide.rightAnchor,
                            paddingTop: 8,
                            paddingLeft: 0,
                            paddingBottom: 8,
                            paddingRight: 0,
                            width: 0,
                            height: 0,
                            enableInsets: true)
        
    }
    
    private func fetchNote() {
        if let id = userId {
            presenter?.fetchNoteWith(userId: id)
        }
    }
    
    private func addNote(with note: String) {
        if let id = userId{
            presenter?.addNoteWith(userId: id, note: note)
        }
    }
    
    //***** MARK:- IBActions *****    
    @objc private func didTapSaveNoteButton(sender: Any) {
        if noteTextView.text.isEmpty {
            
        }else{
            addNote(with: noteTextView.text)
        }
    }
}

//***** MARK: - NoteDelegate *****
extension NoteViewController: NoteDelegate {
    func addNoteSucceed() {
        print("Note Added")
        self.navigationController?.popViewController(animated: true)
    }
    
    func addNoteDidFailedWith(_ message: String) {
        print("AddNoteDidFailedWith: \(message)")
    }
    
    func fetchNoteSucceddWith(_ note: Note) {
        noteTextView.text = note.note
    }
    
    func fetchNoteDidFailedWith(_ message: String) {
        print("FetchNoteDidFailed: \(message)")
        addNavigationItem()
    }
    
    
}
