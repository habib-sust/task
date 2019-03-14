//
//  HomePresenter.swift
//  Task
//
//  Created by Habib on 14/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import Foundation

protocol HomeDelegate {
    func showProgress()
    func hideProgress()
    func repoDataSucceddWith(_ data: [Repo])
    func repoDataFailedWith(_ message: String)
}
