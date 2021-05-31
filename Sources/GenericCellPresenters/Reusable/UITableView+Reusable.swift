//
//  UITableView+Reusable.swift
//  TheRun
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import UIKit

// MARK: Reusable support for UITableView

public extension UITableView {

    /// Register a Class-Based `UITableViewCell` subclass (conforming to `Reusable`)
    ///
    /// - Parameter cellType: `UITableViewCell` (`Reusable`-conforming) subclass to register
    final func register<T: UITableViewCell>(cellType: T.Type) where T: Reusable {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    /// Returns a reusable `UITableViewCell` object for the class inferred by the return-type
    ///
    /// - Parameters:
    ///   - indexPath: The index path specifying the location of the cell
    ///   - cellType: The cell class to dequeue
    /// - Returns: A `Reusable`, `UITableViewCell` instance
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }

    /// Register a Class-Based `UITableViewHeaderFooterView` subclass (conforming to `Reusable`)
    ///
    /// - Parameter headerFooterViewType: the `UITableViewHeaderFooterView` (`Reusable`-confirming) subclass to register
    final func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type) where T: Reusable {
        register(headerFooterViewType.self, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }

    /// Returns a reusable `UITableViewHeaderFooterView` object for the class inferred by the return-type
    ///
    /// - Parameter viewType: The view class to dequeue
    /// - Returns: A `Reusable`, `UITableViewHeaderFooterView` instance
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T? where T: Reusable {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T? else {
            fatalError(
                "Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) "
                    + "matching type \(viewType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the header/footer beforehand"
            )
        }
        return view
    }
}
