//
//  TableView+Reusable.swift
//  Task
//
//  Created by Habib on 13/3/19.
//  Copyright © 2019 Habib. All rights reserved.
//

import UIKit

protocol Reusable: AnyObject {}

extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibLodable: AnyObject {}

extension NibLodable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: Reusable {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func registerNib<T: UITableViewCell>(_: T.Type) where T: Reusable, T: NibLodable {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))

        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: UITableViewHeaderFooterView>(_: T.Type) where T: Reusable {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: UITableViewHeaderFooterView>(_: T.Type) where T: Reusable, T: NibLodable {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))

        register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
    
    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: Reusable {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return headerFooterView
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: UICollectionViewCell>(_: T.Type) where T: Reusable, T: NibLodable {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))

        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, with type: T.Type) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
}

extension UIView {
    static func fromNib<T: UIView>() -> T where T: NibLodable {
        guard
            let nibViews = Bundle(for: T.self).loadNibNamed(T.nibName, owner: T.self, options: nil),
            let view = nibViews.first(where: { $0 is T }) as? T
            else {
                fatalError("Could not load nib with name: \(T.nibName)")
            }

        return view
    }
}

extension UIViewController {
    static func instantiate<T: UIViewController>(with storyboardName: String) -> T {
        let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)

        guard let controller = storyBoard.instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not instantiate viewController")
        }

        return controller
    }

    static func instantiateFromXib<T: UIViewController>() -> T {
        let controller = T(nibName: String(describing: T.self), bundle: nil)
        return controller
    }
}

// 1. TableView / CollectionView
//   a) register + dequeue cell
//   b) register + dequeue header/footer
// 2. UIViewController
//   a) from storyboard
//   b) from XIB
// 3. UIView
//   a) from XIB

