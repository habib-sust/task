//
//  GenericResult.swift
//  Task
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import Foundation

enum Result<Value> {
    case failure(Error)
    case success(Value)
}

enum APIClientError: Error {
    case noData
}
