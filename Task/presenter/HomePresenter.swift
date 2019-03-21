//
//  HomePresenter.swift
//  Task
//
//  Created by Habib on 14/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import Foundation

protocol HomeViewable {
    func startProgress()
    func hideProgress()
    func repositoriesSucceedWith(_ repositories: [Repository])
    func repositoriesDidFailedWith(_ message: String)
    func fetchRepositoriesFromCacheSucceedWith(_ repositories: [Repository])
    func fetchRepositoriesFromCacheDidFailedWith(_ message: String)
}

protocol RepositoryFetchable {
    func fetchRepositories(from endPoint: String)
    func fetchRepositoriesFromCache(with endPoint: String)
}

struct HomePresenter: RepositoryFetchable {
    private var delegate: HomeViewable
    private var networking: Networking
    
    init(delegate: HomeViewable, networking: Networking) {
        self.delegate = delegate
        self.networking = networking
    }
    
    func fetchRepositories(from endPoint: String) {
        delegate.startProgress()
        networking.get(from: endPoint){ result in
            switch result {
            case .onFailure(let error):
                self.delegate.hideProgress()
                self.delegate.repositoriesDidFailedWith(error.localizedDescription)
            case .onSuccess(let data):
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
    
    func fetchRepositoriesFromCache(with endPoint: String) {
        guard let url = URL(string: endPoint) else{
            self.delegate.fetchRepositoriesFromCacheDidFailedWith("Can't convert to URL")
            return
        }
        let request = URLRequest(url: url)
        delegate.startProgress()
        fetchCaccheRepositoriesWith(request: request, completion: {result in
            switch result {
            case .onSuccess(let repos):
                self.delegate.hideProgress()
                self.delegate.fetchRepositoriesFromCacheSucceedWith(repos)
            case .onFailure(let error):
                self.delegate.hideProgress()
                self.delegate.fetchRepositoriesFromCacheDidFailedWith(error.localizedDescription)
            }
        })
    }
    
    private func fetchCaccheRepositoriesWith(request: URLRequest, completion: @escaping (Result<[Repository]>)-> Void) {
        if let data = URLCache.shared.cachedResponse(for: request)?.data {
            do{
                let repos = try JSONDecoder().decode([Repository].self, from: data)
                completion(.onSuccess(repos))
            }catch(let error) {
                completion(.onFailure(error))
            }
        }
    }
}
