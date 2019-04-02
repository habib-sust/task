//
//  GenericResult.swift
//  Task
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import Foundation

enum Result<Value> {
    case onFailure(Error)
    case onSuccess(Value)
}

enum APIClientError: Error {
    case noData
}
