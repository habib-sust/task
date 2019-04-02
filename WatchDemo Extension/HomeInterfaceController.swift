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
//    private var presenter: HomePresenter?
    private var connectivityHandler = WatchSessionManger.shared
    private var repositories = [Repository]() {
        didSet {
            updateTable()
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

//        presenter = HomePresenter(delegate: self, networking: HTTPNetworking())
//        getRepositoriesData()
    }
    
//    private func getRepositoriesData() {
//        presenter?.fetchRepositories(from: Constants.baseURL)
//    }
    
    func updateTable() {
        tableView.setNumberOfRows(repositories.count, withRowType: "RepositoryRow")
        
        for (index, repository) in repositories.enumerated() {
            if let row = tableView.rowController(at: index) as? RepositoryRow {
                row.reposityNameLabel.setText(repository.repoName)
            }
        }
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        connectivityHandler.startSession()
        connectivityHandler.watchOSDelegate = self
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

extension HomeInterfaceController: WatchOSDelegate {
    func messageReceived(tuple: MessageReceived) {
        print("MessageReceived: \(tuple)")
        DispatchQueue.main.async {
            if let repos = tuple.message["repositories"] as? [Repository] {
                self.repositories = repos
            }
        }
    }
    
    
}

//extension HomeInterfaceController: HomeViewable {
//    func startProgress() {
//        print("startProgress")
//    }
//
//    func hideProgress() {
//        print("hideProgress")
//    }
//
//    func repositoriesSucceedWith(_ repositories: [Repository]) {
//        print("repositoriesSucceedWith")
//        self.repositories = repositories
//    }
//
//    func repositoriesDidFailedWith(_ message: String) {
//        print("repositoriesDidFailedWith: \(message)")
//    }
//
//    func fetchRepositoriesFromCacheSucceedWith(_ repositories: [Repository]) {
//
//    }
//
//    func fetchRepositoriesFromCacheDidFailedWith(_ message: String) {
//
//    }
//
//
//}
