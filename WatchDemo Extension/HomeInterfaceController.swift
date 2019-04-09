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
    
    //MARK: LifeCycle
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        connectivityHandler.watchOSDelegate = self
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    //MARK: Table
    func updateTable() {
        tableView.setNumberOfRows(repositories.count, withRowType: "RepositoryRow")
        for (index, repository) in repositories.enumerated() {
            if let row = tableView.rowController(at: index) as? RepositoryRow {
                row.configureRow(repoName: repository.repoName)
            }
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        if let userId = repositories[rowIndex].id{
            goToNoteInterfaceController(with: userId)
        }
    }
    
    //MARK: - Private Methods
    private func goToNoteInterfaceController(with context: Any) {
        presentController(withName: "Note", context: context)
    }
    
    private func decodeRepositories(from data: Data) {
        do{
            let decoder = JSONDecoder()
            repositories = try decoder.decode([Repository].self, from: data)
        }catch (let error) {
            print("Error in Decoding: \(error.localizedDescription)")
        }
    }
    

    private func textInput() {
        presentTextInputController(withSuggestions: nil, allowedInputMode: WKTextInputMode.plain, completion: { result in
            guard let choice = result else {
                return
            }
            print(choice)
        })
    }
}

//MARK: - WatchOSDelegate
extension HomeInterfaceController: WatchOSDelegate {
    func messageReceived(tuple: MessageReceived) {
        DispatchQueue.main.async {
            if let data = tuple.message["repositories"] as? Data {
                self.decodeRepositories(from: data)
            }
            
            if let noteInfo = tuple.message["noteInfo"] {
                print("Note Info: \(noteInfo)")
                    self.goToNoteInterfaceController(with: noteInfo)
            }
        }
    }
}
