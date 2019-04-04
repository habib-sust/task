//
//  RepositoryRow.swift
//  WatchDemo Extension
//
//  Created by Habib on 2/4/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import WatchKit

class RepositoryRow: NSObject {
    @IBOutlet weak var repositoryNameLabel: WKInterfaceLabel!
    
    func configureRow(repoName: String?) {
        repositoryNameLabel.setText(repoName)
    }
}
