//
//  Networking.swift
//  Task
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import Foundation

protocol NetWorking {
    typealias completionHandler = (Result<Data>) -> Void
    func get(from stringURL: String, completion: @escaping completionHandler)
}


