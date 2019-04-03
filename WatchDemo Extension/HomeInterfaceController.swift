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
    private var repositories = [Repository](){
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
                
                row.reposityNameLabel.setText(repository.repoName)
            }
        }
    }
    
    override func willActivate() {
        super.willActivate()
        connectivityHandler.watchOSDelegate = self
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    private func goToNoteInterfaceController(with note: String) {
        presentController(withName: "Note", context: note)
    }
    
    private func decodeRepositories(from data: Data) {
        do{
            let decoder = JSONDecoder()
            repositories = try decoder.decode([Repository].self, from: data)
        }catch (let error) {
            print("Error in Decoding: \(error.localizedDescription)")
        }
    }
}

extension HomeInterfaceController: WatchOSDelegate {
    func messageReceived(tuple: MessageReceived) {
        DispatchQueue.main.async {
            if let data = tuple.message["repositories"] as? Data {
                self.decodeRepositories(from: data)
            }
            
            if let note = tuple.message["note"] as? String {
                self.goToNoteInterfaceController(with: note)
            }
        }
    }
}
