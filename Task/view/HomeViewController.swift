//
//  ViewController.swift
//  Task
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    //***** MARK: - Properties *****
    fileprivate var repositories = [Repository]()
    fileprivate var progressHud: UIActivityIndicatorView!
    fileprivate var tableView = UITableView()
    fileprivate var presenter: HomePresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        createActivityIndicator()
        getRepositoriesData()
    }

    //***** MARK: - Private Methods
    private func setup() {
        view.backgroundColor = .white
        presenter = HomePresenter(delegate: self, networking: HTTPNetworking())
        
//        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 10,
                         paddingLeft: 0,
                         paddingBottom: 8,
                         paddingRight: 0,
                         width: 0,
                         height: 0,
                         enableInsets: true)

    }
    private func getRepositoriesData() {
        presenter?.fetch(from: Constants.baseURL)
    }
    
    private func createActivityIndicator () {
        let container: UIView = UIView()
        container.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        container.backgroundColor = .clear
        
        progressHud = UIActivityIndicatorView(style: .gray)
        progressHud.center = view.center
        progressHud.hidesWhenStopped = true
        container.addSubview(progressHud)
        view.addSubview(container)
    }
    
    private func gotToNoteViewControllerWith(userId: Int?) {
        let controller = NoteViewController()
        controller.userId = userId
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func progressHudStartAnimating() {
        DispatchQueue.main.async {
            self.progressHud.startAnimating()
        }
    }
    
    func progressHudStopAnimating() {
        DispatchQueue.main.async {
            self.progressHud.stopAnimating()
        }
    }
}

//***** Mark: HomeDelegate
extension HomeViewController: HomeDelegate {
    func fetchRepositoriesFromCacheSucceedWith(_ repositories: [Repository]) {
        self.repositories = repositories
        updateUI()
    }
    
    func fetchRepositoriesFromCacheDidFailedWith(_ message: String) {
        print("FetchRepositoriesFromCacheDidFailedWith: \(message)")
    }
    
    func startProgress() {
        print("start progress")
        progressHudStartAnimating()
    }
    
    func hideProgress() {
        print("Hide progess")
        progressHudStopAnimating()
    }
    
    func repositoriesSucceedWith(_ repositories: [Repository]) {
//        print("RepositoriesSucceedWith: \(repositories)")
        self.repositories = repositories
        updateUI()
    }
    
    func repositoriesDidFailedWith(_ message: String) {
        print("RepositoriesDidFailedWith: \(message)")
    }
}


//MARK: - TableView Delegate & DataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    //***** MARK: TableView Delegate & DataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath, withType: RepoCell.self)
        cell.updateCell(with: repositories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userId = repositories[indexPath.row].id
        gotToNoteViewControllerWith(userId: userId)
    }

}
