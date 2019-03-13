//
//  EndPoint.swift
//  Task
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import Foundation

protocol EndPoint {}

extension EndPoint {
    static var path: String {
        return "https://api.github.com/orgs/facebook/repos"
    }
}
