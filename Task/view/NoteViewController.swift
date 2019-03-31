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
    
    //***** MARK:- Properties *****
    var userId: Int?
    private var isSave = true
    //***** MARK:- View LifeCycle *****
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NotePresenter(delegate: self)
        backgroundSetup()
        addNoteTextView()
        setupConstraints()
        addNavigationItem()
        fetchNote()
    }

    //***** MARK: - Private Methods *****
    private func backgroundSetup() {
        view.backgroundColor = .white
    }
    
    private func addNoteTextView() {
        view.addSubview(noteTextView)
    }
    
    private func noteTextViewIsEditable(isEditable: Bool) {
        noteTextView.isEditable = isEditable
    }
    
    private func addNavigationItem() {
        let saveNoteButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveNoteButton(sender:)))
        let editNoteButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditNoteButton(sender:)))
        
        navigationItem.rightBarButtonItems = [editNoteButton,saveNoteButton]
    }
    
    private func toggleNavigationBarButton(isEditButton: Bool) {
        navigationItem.rightBarButtonItems?.first?.isEnabled = isEditButton
        navigationItem.rightBarButtonItems?.last?.isEnabled = !isEditButton
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
    
    private func editNote(with note: String) {
        if let id = userId {
            presenter?.editNoteWith(userId: id, newNote: note)
        }
    }
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Note", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //***** MARK:- IBActions *****    ≥
    @objc private func didTapSaveNoteButton(sender: Any) {
        if noteTextView.text.isEmpty {
            let message = "Note can't be blank"
            showAlert(with: message)
        }else{
            isSave ? addNote(with: noteTextView.text) : editNote(with: noteTextView.text)
        }
    }
    
    @objc private func didTapEditNoteButton(sender: Any) {
        toggleNavigationBarButton(isEditButton: false)
        noteTextViewIsEditable(isEditable: true)
        isSave = false
    }
}

//***** MARK: - NoteViewable Delegate *****
extension NoteViewController: NoteViewable {
    func addOrEditNoteSucceed() {
        navigationController?.popViewController(animated: true)
    }
    
    func addOrEditNoteDidFailedWith(_ message: String) {
        showAlert(with: message)
    }
    
    func fetchNoteSucceddWith(_ note: Note) {
        noteTextView.text = note.note
        toggleNavigationBarButton(isEditButton: true)
    }
    
    func fetchNoteDidFailedWith(_ message: String) {
        noteTextViewIsEditable(isEditable: true)
        toggleNavigationBarButton(isEditButton: false)
    }
    
}
