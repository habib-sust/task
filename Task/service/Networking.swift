//
//  Networking.swift
//  Task
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import Foundation

protocol Networking {
    typealias completionHandler = (Result<Data>) -> Void
    func get(from stringURL: String, onCompletion: @escaping completionHandler)
}

struct HTTPNetworking: Networking {
    
    func get(from stringURL: String, onCompletion: @escaping completionHandler) {
        guard let url = URL(string: stringURL) else{return}
        let request = createRequest(from: url)
        let task = createDataTask(from: request, onCompletion: onCompletion)
        task.resume()
    }
    
    //******* MARK: - Private Methods *******
    private func createRequest(from url: URL) -> URLRequest{
        var request = URLRequest(url: url)
        request.cachePolicy = .useProtocolCachePolicy
        return request
    }
    
    private func createDataTask(from request: URLRequest, onCompletion: @escaping completionHandler) -> URLSessionDataTask{
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            if let error = error {
                onCompletion(.onFailure(error))
                return
            }
            
            guard let data = data else{
                onCompletion(.onFailure(APIClientError.noData))
                return
            }
            if let response = response {
                let cacheData = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cacheData, for: request)
                
            }
            onCompletion(.onSuccess(data))
        }
        return task
    }
}
