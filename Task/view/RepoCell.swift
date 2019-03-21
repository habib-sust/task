
//
//  RepoCell.swift
//  Task
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import UIKit
import Kingfisher

class RepoCell: UITableViewCell, ReusableView {
    
    private struct ViewMatrix {
        static let avatarImageViewWidth: CGFloat = 80
        static let avatarImageViewPaddingLeft: CGFloat = 5
        static let descriptionViewPaddingLeft: CGFloat = 8
    }
    
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
                               paddingLeft: ViewMatrix.avatarImageViewPaddingLeft,
                               paddingBottom: 0,
                               paddingRight: 0,
                               width: ViewMatrix.avatarImageViewWidth,
                               height: 0,
                               enableInsets: false)
        
        descriptionView.anchor(top: topAnchor,
                               left: avatarImageView.rightAnchor,
                               bottom: bottomAnchor,
                               right: rightAnchor,
                               paddingTop: 0,
                               paddingLeft: ViewMatrix.descriptionViewPaddingLeft,
                               paddingBottom: 0,
                               paddingRight: 0,
                               width: 0,
                               height: 0,
                               enableInsets: false)

    }
    
    private func createCircularImage() {
        avatarImageView.layer.cornerRadius = bounds.size.height/2
        avatarImageView.layer.borderWidth = 2.0
        avatarImageView.layer.borderColor = UIColor.clear.cgColor
        avatarImageView.layer.masksToBounds = true
    }
    
    
    func configureCell(with repository: Repository){
        if let isFork = repository.fork {
            backgroundColor = isFork ? .customYellow : UIColor.white
        }
        
        if let avatarURL = repository.owner?.avatarURL {
            let url = URL(string: avatarURL)
            avatarImageView.kf.setImage(with: url)
        }
        
        descriptionView.ownerName = repository.owner?.ownerName
        descriptionView.repositoryName = repository.repoName
        descriptionView.repoDescription = repository.description
        createCircularImage()
    }
}

