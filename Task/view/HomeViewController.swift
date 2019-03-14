//
//  ViewController.swift
//  Task
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    //***** MARK: - Properties *****
    fileprivate var repositories = [Repository]()
    fileprivate var presenter: HomePresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getRepositoriesData()
    }

    //***** MARK: - Private Methods
    private func setup() {
        presenter = HomePresenter(delegate: self, networking: HTTPNetworking())
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.reuseIdentifier)
    }
    
    private func getRepositoriesData() {
        presenter?.fetch(from: Constants.baseURL)
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //***** MARK: TableView Delegate & DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath, withType: RepoCell.self)
        cell.updateCell(with: repositories[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
    }
}

//***** Mark: HomeDelegate
extension HomeViewController: HomeDelegate {
    func startProgress() {
        print("start progress")
    }
    
    func hideProgress() {
        print("Hide progess")
    }
    
    func repositoriesSucceedWith(_ repositories: [Repository]) {
        print("RepositoriesSucceedWith: \(repositories)")
        self.repositories = repositories
        updateUI()
    }
    
    func repositoriesDidFailedWith(_ message: String) {
        print("RepositoriesDidFailedWith: \(message)")
    }
    
    
}
