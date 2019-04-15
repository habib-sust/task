
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
    private struct ViewMetrics {
        static let avatarImageViewWidth: CGFloat = 50
        static let avatarImageViewHeight: CGFloat = 50
        static let avatarImageViewPaddingLeft: CGFloat = 5
        static let descriptionViewPaddingLeft: CGFloat = 8
    }
    
    //***** MARK: - Views *****
    private var avatarImageView = UIImageView()
    private var descriptionView = DescriptionView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupContraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        createCircularImage()
    }
    
    //MARK: - Private Methods
    private func setup() {
        self.accessibilityIdentifier = "RepoCell"
        avatarImageView.contentMode = .scaleAspectFit
        addSubview(avatarImageView)
        addSubview(descriptionView)
        
    }
    
    private func setupContraints() {
        avatarImageView.anchor(top: topAnchor,
                               left: leftAnchor,
                               bottom: nil,
                               right: nil,
                               paddingTop: 0,
                               paddingLeft: ViewMetrics.avatarImageViewPaddingLeft,
                               paddingBottom: 0,
                               paddingRight: 0,
                               width: ViewMetrics.avatarImageViewWidth,
                               height: ViewMetrics.avatarImageViewHeight,
                               enableInsets: false)
        
        descriptionView.anchor(top: topAnchor,
                               left: avatarImageView.rightAnchor,
                               bottom: bottomAnchor,
                               right: rightAnchor,
                               paddingTop: 0,
                               paddingLeft: ViewMetrics.descriptionViewPaddingLeft,
                               paddingBottom: 0,
                               paddingRight: 0,
                               width: 0,
                               height: 0,
                               enableInsets: false)

    }
    
    private func createCircularImage() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height/2
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
    }
}

