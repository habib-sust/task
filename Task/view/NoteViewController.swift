//
//  NoteViewController.swift
//  Task
//
//  Created by Habib on 14/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import UIKit

final class NoteViewController: UIViewController {
    private struct ViewMetrics {
        static let noteTextViewFontSize: CGFloat = 14
    }
    //***** MARK: - Views *****
    private var noteTextView: UITextView =  {
        let textView = UITextView()
        textView.font = UIFont(name: "Avenir", size: ViewMetrics.noteTextViewFontSize)
        textView.isEditable = false
        return textView
    }()
    
    private var presenter: NotePresenter?
    
    //*****MARK:- Properties *****
    var userId: Int?
    
    //*****MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NotePresenter(delegate: self)
        backgroundSetup()
        addNoteTextView()
        setupConstraints()
        fetchNote()
    }

    //***** MARK: - Private Methods *****
    private func backgroundSetup() {
        view.backgroundColor = .white
    }
    
    private func addNoteTextView() {
        view.addSubview(noteTextView)
    }
    
    private func NoteTextViewIsEditable(isEditable: Bool) {
        noteTextView.isEditable = isEditable
    }
    
    private func addNavigationItem() {
        let saveNoteButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveNoteButton(sender:)))
        navigationItem.rightBarButtonItems = [saveNoteButton]
    }
    

    private func setupConstraints() {
        noteTextView.anchor(top: view.topAnchor,
                            left: view.readableContentGuide.leftAnchor,
                            bottom: view.bottomAnchor,
                            right: view.readableContentGuide.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
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
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Note", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    //***** MARK:- IBActions *****    
    @objc private func didTapSaveNoteButton(sender: Any) {
        if noteTextView.text.isEmpty {
            let message = "Note can't be blank"
            showAlert(with: message)
        }else{
            addNote(with: noteTextView.text)
        }
    }
}

//***** MARK: - NoteDelegate *****
extension NoteViewController: NoteViewable {
    func addNoteSucceed() {
        navigationController?.popViewController(animated: true)
    }
    
    func addNoteDidFailedWith(_ message: String) {
        showAlert(with: message)
    }
    
    func fetchNoteSucceddWith(_ note: Note) {
        noteTextView.text = note.note
    }
    
    func fetchNoteDidFailedWith(_ message: String) {
        NoteTextViewIsEditable(isEditable: true)
        addNavigationItem()
    }
    
    
}
