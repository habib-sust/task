//
//  DescriptionView.swift
//  Task
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import UIKit
class DescriptionView: UIView{
    var reponeName: String? {
        didSet {
            repoNameLabel.text = reponeName
        }
    }
    
    var ownerName: String? {
        didSet {
            ownerNameLabel.text = ownerName
        }
    }
    
    var repoDescription: String? {
        didSet {
            descriptionLabel.text = repoDescription
        }
    }
    
    //***** MARK:- Views *****
    private var repoNameLabel = UILabel()
    private var ownerNameLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var descriptionView = UIStackView()
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        repoNameLabel = setupLabel(label: repoNameLabel, withNumberOfLines: 1)
        ownerNameLabel = setupLabel(label: ownerNameLabel, withNumberOfLines: 1)
        descriptionLabel = setupLabel(label: descriptionLabel, withNumberOfLines: 0)
        setupDescriptionStackView()
        setup()
        setupConstraints()
    }
    
    
    //***** MARK: - Private Methods ******
    private func setupDescriptionStackView() {
        descriptionView = UIStackView(arrangedSubviews: [repoNameLabel, ownerNameLabel, descriptionLabel])
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.axis = .vertical
        descriptionView.distribution = .fillProportionally
    }

    private func setupLabel(label: UILabel, withNumberOfLines lines: Int) -> UILabel{
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = lines
        return label
    }
    
    private func setup() {
        repoNameLabel.backgroundColor = .orange
        ownerNameLabel.backgroundColor = .red
        descriptionLabel.backgroundColor = .green
        
        addSubview(descriptionView)
    }

    private func setupConstraints() {
        descriptionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
}
