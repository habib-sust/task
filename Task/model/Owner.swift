//
//  Owner.swift
//  Task
//
//  Created by Habib on 14/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import Foundation

struct Owner : Codable, Equatable {
    let ownerName : String?
    let avatarURL : String?
    
    enum CodingKeys: String, CodingKey {
        case ownerName = "login"
        case avatarURL = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ownerName = try values.decodeIfPresent(String.self, forKey: .ownerName)
        avatarURL = try values.decodeIfPresent(String.self, forKey: .avatarURL)
    }
}
