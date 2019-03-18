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
    func fetchRepositoriesFromCacheSucceedWith(_ repositories: [Repository])
    func fetchRepositoriesFromCacheDidFailedWith(_ message: String)
}

protocol RepositoryFetcher {
    func fetch(from endPoint: String)
    func fetchFromCache(with endPoint: String)
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
    
    func fetchFromCache(with endPoint: String) {
        guard let url = URL(string: endPoint) else{return}
        let request = URLRequest(url: url)
        delegate.startProgress()
        fetchCaccheRepositoriesWith(request: request, completion: {result in
            switch result {
            case .success(let repos):
                self.delegate.startProgress()
                self.delegate.fetchRepositoriesFromCacheSucceedWith(repos)
            case .failure(let error):
                self.delegate.startProgress()
                self.delegate.fetchRepositoriesFromCacheDidFailedWith(error.localizedDescription)
            }
        })
    }
    
    private func fetchCaccheRepositoriesWith(request: URLRequest, completion: @escaping (Result<[Repository]>)-> Void){
        if let data = URLCache.shared.cachedResponse(for: request)?.data {
            do{
                let repos = try JSONDecoder().decode([Repository].self, from: data)
                completion(.success(repos))
                print("Load From Caching")
            }catch(let error) {
                completion(.failure(error))
            }
        }
    }
    
}
