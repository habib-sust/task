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
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        repoNameLabel = createLabel(label: repoNameLabel, withNumberOfLines: 1)
        ownerNameLabel = createLabel(label: ownerNameLabel, withNumberOfLines: 1)
        descriptionLabel = createLabel(label: descriptionLabel, withNumberOfLines: 0)
        setup()
        setupConstraints()
    }
    
    //***** MARK: - Private Methods ******
    private func createLabel(label: UILabel, withNumberOfLines lines: Int) -> UILabel{
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
        
        addSubview(repoNameLabel)
        addSubview(ownerNameLabel)
        addSubview(descriptionLabel)
    }

    func setupConstraints() {
        repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        ownerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let repoNameLabelTop = repoNameLabel.topAnchor.constraint(equalTo: topAnchor)
        let repoNameLabelLeading = repoNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        let repoNameLabelTrainling = repoNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        let ownerNameLabelTop = ownerNameLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor)
        let ownerNameLabelLeading = ownerNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        let ownerNameLabelTrainling = ownerNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        let descriptionLabelTop = descriptionLabel.topAnchor.constraint(equalTo: ownerNameLabel.bottomAnchor)
        let descriptionLabelLeading = descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        let descriptionLabelTrailing = descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        let descriptionLabelBottom = descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        NSLayoutConstraint.activate([
            repoNameLabelTop, repoNameLabelLeading, repoNameLabelTrainling,
            ownerNameLabelTop, ownerNameLabelLeading, ownerNameLabelTrainling,
            descriptionLabelTop, descriptionLabelLeading, descriptionLabelTrailing, descriptionLabelBottom])
        
        
        descriptionLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
