
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
        
        avatarImageView.anchor(top: topAnchor,
                               left: leftAnchor,
                               bottom: bottomAnchor,
                               right: nil,
                               paddingTop: 0,
                               paddingLeft: 5,
                               paddingBottom: 0,
                               paddingRight: 0,
                               width: 80,
                               height: 0,
                               enableInsets: true)
        
        descriptionView.anchor(top: topAnchor,
                               left: avatarImageView.rightAnchor,
                               bottom: bottomAnchor,
                               right: rightAnchor,
                               paddingTop: 0,
                               paddingLeft: 8,
                               paddingBottom: 0,
                               paddingRight: 0,
                               width: 0,
                               height: 0,
                               enableInsets: true)
        
//        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
//        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
//        let avatarImageViewTop = avatarImageView.topAnchor.constraint(equalTo: topAnchor)
//        let avatarImageViewBottom = avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        let avataImageViewLeading = avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
//        let avataImageViewWidth = avatarImageView.widthAnchor.constraint(equalToConstant: 60)
//        
//        let descriptionViewTop = descriptionView.topAnchor.constraint(equalTo: topAnchor)
//        let descriptionViewLeading = descriptionView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor)
//        let descriptionViewTrailing = descriptionView.trailingAnchor.constraint(equalTo: trailingAnchor)
//        let descriptionViewBottom = descriptionView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        
//        NSLayoutConstraint.activate([
//            avatarImageViewTop, avatarImageViewBottom, avataImageViewLeading, avataImageViewWidth,
//            descriptionViewTop, descriptionViewLeading, descriptionViewTrailing, descriptionViewBottom])
//        
//        descriptionView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
    }
}
