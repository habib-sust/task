//
//  InterfaceController.swift
//  WatchDemo Extension
//
//  Created by Habib on 2/4/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import WatchKit
import Foundation
class HomeInterfaceController: WKInterfaceController {

    @IBOutlet weak var tableView: WKInterfaceTable!
    
    private var connectivityHandler = WatchSessionManger.shared
    private var repositories = [String]() {
        didSet {
            updateTable()
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    
    func updateTable() {
        tableView.setNumberOfRows(repositories.count, withRowType: "RepositoryRow")
        
        for (index, repository) in repositories.enumerated() {
            if let row = tableView.rowController(at: index) as? RepositoryRow {
                row.reposityNameLabel.setText(repository)
            }
        }
    }
    
    override func willActivate() {
        super.willActivate()
        connectivityHandler.startSession()
        connectivityHandler.watchOSDelegate = self
        
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    private func goToNoteInterfaceController(with note: String) {
        presentController(withName: "Note", context: note)
    }

}

extension HomeInterfaceController: WatchOSDelegate {
    func messageReceived(tuple: MessageReceived) {
        DispatchQueue.main.async {
            if let repos = tuple.message["repositories"] as? [String] {
                self.repositories = repos
            }
            
            if let note = tuple.message["note"] as? String {
                self.goToNoteInterfaceController(with: note)
            }
        }
    }
}
