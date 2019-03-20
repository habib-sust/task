//
//  ViewController.swift
//  Task
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import UIKit
final class HomeViewController: UIViewController {
    //***** MARK: - Views *****
    private var progressHud: UIActivityIndicatorView = {
        let progressHud = UIActivityIndicatorView(style: .gray)
        progressHud.hidesWhenStopped = true
        return progressHud
    }()
    private var tableView = UITableView()
    
    //***** MARK: - Properties *****
    private let viewMatrix = HomeViewMatrix()
    private var repositories = [Repository]()
    private var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(delegate: self, networking: HTTPNetworking())
        setupBackground()
        setupTableView()
        setupConstraints()
        setupProgressHud()
        getRepositoriesData()
    }

    //***** MARK: - Private Methods
    private func setupBackground() {
        view.backgroundColor = .white
    }
    
    private func setupTableView() {
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
                         paddingTop: viewMatrix.tableViewPaddingTop,
                         paddingLeft: 0,
                         paddingBottom: viewMatrix.tableViewPaddingBottom,
                         paddingRight: 0,
                         width: 0,
                         height: 0,
                         enableInsets: true)

    }
    
    private func getRepositoriesData() {
        presenter?.fetchRepositories(from: Constants.baseURL)
    }
    
    private func setupProgressHud () {
        progressHud.center = view.center
        view.addSubview(progressHud)
    }
    
    private func gotToNoteViewControllerWith(userId: Int?) {
        let controller = NoteViewController()
        controller.userId = userId
        navigationController?.pushViewController(controller, animated: true)
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
extension HomeViewController: HomeView {
    func fetchRepositoriesFromCacheSucceedWith(_ repositories: [Repository]) {
        self.repositories = repositories
        updateUI()
    }
    
    func fetchRepositoriesFromCacheDidFailedWith(_ message: String) {
        
    }
    
    func startProgress() {
        progressHudStartAnimating()
    }
    
    func hideProgress() {
        progressHudStopAnimating()
    }
    
    func repositoriesSucceedWith(_ repositories: [Repository]) {
        self.repositories = repositories
        updateUI()
    }
    
    func repositoriesDidFailedWith(_ message: String) {
        presenter?.fetchRepositoriesFromCache(with: Constants.baseURL)
    }
}


//MARK: - TableView Delegate & DataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath, withType: RepoCell.self)
        cell.configureCell(with: repositories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewMatrix.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userId = repositories[indexPath.row].id
        gotToNoteViewControllerWith(userId: userId)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        return footerView
    }
}


struct HomeViewMatrix {
    let cellHeight: CGFloat = 80
    let tableViewPaddingTop: CGFloat = 10
    let tableViewPaddingBottom: CGFloat = 10
}
