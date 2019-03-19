//
//  MockRepositories.swift
//  TaskTests
//
//  Created by Habibur Rahman on 18/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import Foundation
@testable import Task

struct MockRepository {
    static var data: [String: Any?] {
        let jsonData: [String: Any?] = [
                "id": 1,
                "name": "codemod",
                "description": "description",
                "fork": false,
                "owner": [
                    "login": "facebook",
                    "avatar_url": "avatar url"
                ]
            ]
        return jsonData
    }
}

struct MockRepositories {
    static var data: [[String: Any?]?] {
        let jsonData: [[String: Any?]?] = [
            [
                "id": 1,
                "name": "codemod",
                "description": "description",
                "fork": false,
                "owner": [
                    "login": "facebook",
                    "avatar_url": "avatar url"
                ]
            ]
        ]
        return jsonData
    }
}
struct MockOwner {
    static var data: [String: Any?] {
        let JSONData: [String: Any?] = [
            "login": "facebook",
            "avatar_url": "avatar url"
            
        ]
        return JSONData
    }
}
