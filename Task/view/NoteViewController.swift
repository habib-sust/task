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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        setupNavigationItem()
    }

    //***** MARK: - Private Methods *****
    private func setup() {
        noteTextView.backgroundColor = .green
        view.backgroundColor = .white
        view.addSubview(noteTextView)
    }
    
    private func setupNavigationItem() -> Void {
        let addNoteButton   = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddNoteButton(sender:)))
        let saveNoteButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveNoteButton(sender:)))
        navigationItem.rightBarButtonItems = [addNoteButton, saveNoteButton]
    }
    
    private func setupConstraints() {
        noteTextView.anchor(top: view.topAnchor,
                            left: view.leftAnchor,
                            bottom: view.bottomAnchor,
                            right: view.rightAnchor,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0,
                            height: 0,
                            enableInsets: true)
        
    }
    
    //***** MARK:- IBActions *****
    @objc private func didTapAddNoteButton(sender: Any) {
        
    }
    
    @objc private func didTapSaveNoteButton(sender: Any) {
        
    }
}
