
//
//  RepoCell.swift
//  Task
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell, ReusableView {
    //***** MARK: - Views *****
    private var avatarImageView = UIImageView()
    private var descriptionView = DescriptionView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        setupContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setup() {
        avatarImageView.backgroundColor = .magenta
        avatarImageView.contentMode = .scaleAspectFit
        
        addSubview(avatarImageView)
        addSubview(descriptionView)
    }
    
    private func setupContraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        let avatarImageViewTop = avatarImageView.topAnchor.constraint(equalTo: topAnchor)
        let avatarImageViewBottom = avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        let avataImageViewLeading = avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        
        let descriptionViewTop = descriptionView.topAnchor.constraint(equalTo: topAnchor)
        let descriptionViewLeading = descriptionView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor)
        let descriptionViewTrailing = descriptionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        let descriptionViewBottom = descriptionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        NSLayoutConstraint.activate([
            avatarImageViewTop, avatarImageViewBottom, avataImageViewLeading,
            descriptionViewTop, descriptionViewLeading, descriptionViewTrailing, descriptionViewBottom])
        
    }
}
