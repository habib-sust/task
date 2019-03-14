//
//  Note.swift
//  Task
//
//  Created by Habib on 14/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object{
    @objc dynamic var userId = 0 
    @objc dynamic var note = ""
}
