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
        userId = 1234
        setup()
        setupConstraints()
        addNavigationItem()
        presenter = NotePresenter(delegate: self)
        fetchNote()
    }

    //***** MARK: - Private Methods *****
    private func setup() {
        noteTextView.backgroundColor = .green
        view.backgroundColor = .white
        view.addSubview(noteTextView)
        noteTextView.font = .systemFont(ofSize: 12)
    }
    
    private func addNavigationItem() {
        let addNoteButton   = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddNoteButton(sender:)))
        let saveNoteButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveNoteButton(sender:)))
        navigationItem.rightBarButtonItems = [addNoteButton, saveNoteButton]
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
    
    private func addNote(userId: Int, note: String) {
        presenter?.addNoteWith(userId: userId, note: note)
    }
    //***** MARK:- IBActions *****
    @objc private func didTapAddNoteButton(sender: Any) {
        
    }
    
    @objc private func didTapSaveNoteButton(sender: Any) {
        
    }
}

//***** MARK: - NoteDelegate *****
extension NoteViewController: NoteDelegate {
    func addNoteSucceed() {
        
    }
    
    func addNoteDidFailedWith(_ message: String) {
        
    }
    
    func fetchNoteSucceddWith(_ note: Note) {
        noteTextView.text = note.note
    }
    
    func fetchNoteDidFailedWith(_ message: String) {
        print("FetchNoteDidFailed: \(message)")
    }
    
    
}
