//
//  DescriptionView.swift
//  Task
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import UIKit
class DescriptionView: UIView{
    private struct ViewMatrix {
        static  let stackViewPaddingTop: CGFloat = 4
        static let stackViewPaddingBottom: CGFloat = 4
        static let stackViewSpacing: CGFloat = 4
    }
    
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
    private var repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Bold", size: 14)
        label.textAlignment = .left
        return label
    }()
    private var ownerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 13)
        label.textAlignment = .left
        return label
    }()
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 12)
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        return label
    }()
    
    private var descriptionView = UIStackView()
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        setupDescriptionStackView()
        setup()
        setupConstraints()
    }
    
    
    //***** MARK: - Private Methods ******
    private func setupDescriptionStackView() {
        descriptionView = UIStackView(arrangedSubviews: [repositoryNameLabel, ownerNameLabel, descriptionLabel])
        descriptionView.axis = .vertical
        descriptionView.spacing = ViewMatrix.stackViewSpacing
        descriptionView.distribution = .fillProportionally
    }
    
    private func setup() {
        addSubview(descriptionView)
    }

    private func setupConstraints() {
        descriptionView.anchor(top: topAnchor,
                               left: leftAnchor,
                               bottom: bottomAnchor,
                               right: rightAnchor,
                               paddingTop: ViewMatrix.stackViewPaddingTop,
                               paddingLeft: 0,
                               paddingBottom: ViewMatrix.stackViewPaddingBottom,
                               paddingRight: 0,
                               width: 0,
                               height: 0,
                               enableInsets: false)
        
    }
}


