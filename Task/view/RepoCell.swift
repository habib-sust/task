
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
                               enableInsets: false)
        
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
                               enableInsets: false)

    }
    
    private func createCircularImage() {
        self.avatarImageView.layer.cornerRadius = self.bounds.size.height/2
        self.avatarImageView.layer.borderWidth = 2.0
        self.avatarImageView.layer.borderColor = UIColor.clear.cgColor
        self.avatarImageView.layer.masksToBounds = true
    }
    
    
    func updateCell(with repository: Repository){
        if let isFork = repository.fork {
            self.backgroundColor = isFork ? Colors.YELLOW : UIColor.white
        }
        
        if let avatarURL = repository.owner?.avatarURL {
            avatarImageView.downloaded(from: avatarURL)
        }
        
        descriptionView.ownerName = repository.owner?.ownerName
        descriptionView.repositoryName = repository.repoName
        descriptionView.repoDescription = repository.description
        createCircularImage()
    }
}
