//
//  HomePresenter.swift
//  Task
//
//  Created by Habib on 14/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import Foundation

protocol HomeViewable: AnyObject {
    func startProgress()
    func hideProgress()
    func repositoriesSucceedWith(_ repositories: [Repository])
    func repositoriesDidFailedWith(_ message: String)
    func fetchRepositoriesFromCacheSucceedWith(_ repositories: [Repository])
    func fetchRepositoriesFromCacheDidFailedWith(_ message: String)
}

protocol RepositoryFetchable {
    func fetchRepositories(from stringURL: String)
    func fetchRepositoriesFromCache(with stringURL: String)
}

struct HomePresenter: RepositoryFetchable {
    private weak var delegate: HomeViewable?
    private var networking: Networking
    
    init(delegate: HomeViewable, networking: Networking) {
        self.delegate = delegate
        self.networking = networking
    }
    
    func fetchRepositories(from stringURL: String) {
        delegate?.startProgress()
        networking.get(from: stringURL){ [weak delegate] result in
            switch result {
            case .onFailure(let error):
                delegate?.hideProgress()
                delegate?.repositoriesDidFailedWith(error.localizedDescription)
            case .onSuccess(let data):
                do{
                    let repositories = try JSONDecoder().decode([Repository].self, from: data)
                    delegate?.hideProgress()
                    delegate?.repositoriesSucceedWith(repositories)
                }catch(let error) {
                    delegate?.hideProgress()
                    delegate?.repositoriesDidFailedWith(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchRepositoriesFromCache(with stringURL: String) {
        guard let url = URL(string: stringURL) else{
            delegate?.fetchRepositoriesFromCacheDidFailedWith("Can't convert to URL")
            return
        }
        let request = URLRequest(url: url)
        delegate?.startProgress()
        fetchCaccheRepositoriesWith(request: request, completion: { [weak delegate] result in
            switch result {
            case .onSuccess(let repos):
                delegate?.hideProgress()
                delegate?.fetchRepositoriesFromCacheSucceedWith(repos)
            case .onFailure(let error):
                delegate?.hideProgress()
                delegate?.fetchRepositoriesFromCacheDidFailedWith(error.localizedDescription)
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
    
    //MARK: WatchOS
    func encodeRepositories(from repositories: [Repository]) -> Data? {
        do{
            let decoder = JSONEncoder()
            let data = try decoder.encode(repositories)
            return data
        } catch (let error){
            print("Error in Encoding Repositories: \(error.localizedDescription)")
            return nil
        }
    }
}
