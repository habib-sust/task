//
//  Repo.swift
//  Task
//
//  Created by Habib on 14/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import Foundation
struct Repo : Codable {
    let id: Int?
    let repoName: String?
    let owner: Owner?
    let description: String?
    let fork:Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case repoName = "name"
        case owner
        case description
        case fork
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        repoName = try values.decodeIfPresent(String.self, forKey: .repoName)
        owner = try values.decodeIfPresent(Owner.self, forKey: .owner)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        fork = try values.decodeIfPresent(Bool.self, forKey: .fork)
    }
    
}
