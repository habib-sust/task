//
//  ViewController.swift
//  Task
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import UIKit
final class HomeViewController: UIViewController {
   private struct ViewMetrics {
        static let cellHeight: CGFloat = 80
        static let tableViewPaddingTop: CGFloat = 10
        static let tableViewPaddingBottom: CGFloat = 10
    }

    //***** MARK: - Views *****
    private var progressHud: UIActivityIndicatorView = {
        let progressHud = UIActivityIndicatorView(style: .gray)
        progressHud.hidesWhenStopped = true
        return progressHud
    }()
    private var tableView = UITableView()
    
    //***** MARK: - Properties *****
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
                         paddingTop: ViewMetrics.tableViewPaddingTop,
                         paddingLeft: 0,
                         paddingBottom: ViewMetrics.tableViewPaddingBottom,
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
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func progressHudStartAnimating() {
        DispatchQueue.main.async {
            self.progressHud.startAnimating()
        }
    }
    
    private func progressHudStopAnimating() {
        DispatchQueue.main.async {
            self.progressHud.stopAnimating()
        }
    }
}

//***** Mark: HomeDelegate
extension HomeViewController: HomeViewable {
    func fetchRepositoriesFromCacheSucceedWith(_ repositories: [Repository]) {
        self.repositories = repositories
        updateUI()
    }
    
    func fetchRepositoriesFromCacheDidFailedWith(_ message: String) {
        showAlert(with: message)
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
        return ViewMetrics.cellHeight
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
