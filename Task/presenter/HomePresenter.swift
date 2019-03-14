//
//  HomePresenter.swift
//  Task
//
//  Created by Habib on 14/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import Foundation

protocol HomeDelegate {
    func startProgress()
    func hideProgress()
    func repositoriesSucceedWith(_ repositories: [Repository])
    func repositoriesDidFailedWith(_ message: String)
}

protocol RepositoryFetcher {
    func fetch(from endPoint: String)
}

struct HomePresenter: RepositoryFetcher {
    private var delegate: HomeDelegate
    private var networking: NetWorking
    init(delegate: HomeDelegate, networking: NetWorking) {
        self.delegate = delegate
        self.networking = networking
    }
    
    func fetch(from endPoint: String) {
        delegate.startProgress()
        networking.get(from: endPoint){ result in
            switch result {
            case .failure(let error):
                self.delegate.hideProgress()
                self.delegate.repositoriesDidFailedWith(error.localizedDescription)
            case .success(let data):
                do{
                    let repositories = try JSONDecoder().decode([Repository].self, from: data)
                    self.delegate.hideProgress()
                    self.delegate.repositoriesSucceedWith(repositories)
                }catch(let error) {
                    self.delegate.hideProgress()
                    self.delegate.repositoriesDidFailedWith(error.localizedDescription)
                }
            }
        }
    }
}
