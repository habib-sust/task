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
    private var topContainerView = UIView()
    private var cancelButton = UIButton()
    private var saveButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
    }

    //***** MARK: - Private Methods
    private func setup() {
        topContainerView.backgroundColor = .gray
        noteTextView.backgroundColor = .darkGray
        
        view.addSubview(topContainerView)
        view.addSubview(noteTextView)
    }
    
    private func setupConstraints() {
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        
        topContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        noteTextView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 0).isActive = true
        noteTextView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor).isActive = true
        noteTextView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor).isActive = true
        noteTextView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor).isActive = true
        noteTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
    }
}
