//
//  StringTrailingTrimmedExtension.swift
//  Task
//
//  Created by Habib on 1/4/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import Foundation

extension String {
    func trailingTrimmed() -> String {
        return self.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
    }
}
