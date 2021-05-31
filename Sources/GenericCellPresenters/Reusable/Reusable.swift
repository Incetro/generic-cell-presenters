//
//  Reusable.swift
//  TheRun
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import Foundation

// MARK: Reusable

/// Base protocol for `UITableViewCell` and `UICollectionViewCell`
public protocol Reusable: AnyObject {

    /// Object identifier
    static var reuseIdentifier: String { get }
}

// MARK: - Default implementation

public extension Reusable {

    /// Default object identifier implementation
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
