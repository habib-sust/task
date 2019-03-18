//
//  DescriptionView.swift
//  Task
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import UIKit
class DescriptionView: UIView{
    var repositoryName: String? {
        didSet {
            repositoryNameLabel.text = repositoryName
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
    private var repositoryNameLabel = UILabel()
    private var ownerNameLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var descriptionView = UIStackView()
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        setupDescriptionStackView()
        setup()
        setupLabels()
        setupConstraints()
    }
    
    
    //***** MARK: - Private Methods ******
    private func setupDescriptionStackView() {
        descriptionView = UIStackView(arrangedSubviews: [repositoryNameLabel, ownerNameLabel, descriptionLabel])
        descriptionView.axis = .vertical
        descriptionView.spacing = 2.0
        descriptionView.distribution = .fillProportionally
    }

    private func setupLabels(){
        repositoryNameLabel.font = UIFont(name: "Avenir-Bold", size: 14)
        repositoryNameLabel.textAlignment = .left
        
        ownerNameLabel.font = UIFont(name: "Avenir-Medium", size: 13)
        ownerNameLabel.textAlignment = .left
        
        descriptionLabel.font = UIFont(name: "Avenir", size: 12)
        descriptionLabel.minimumScaleFactor = 0.5
        descriptionLabel.numberOfLines = 0
    }
    
    private func setup() {
        addSubview(descriptionView)
    }

    private func setupConstraints() {
        descriptionView.anchor(top: topAnchor,
                               left: leftAnchor,
                               bottom: bottomAnchor,
                               right: rightAnchor,
                               paddingTop: 4,
                               paddingLeft: 0,
                               paddingBottom: 4,
                               paddingRight: 0,
                               width: 0,
                               height: 0,
                               enableInsets: false)
    }
}
