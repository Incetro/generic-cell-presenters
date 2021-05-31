//
//  ReusableCellHolder.swift
//  AppName
//
//  Created by incetro on 03/04/2018.
//  Copyright © 2018 incetro. All rights reserved.
//

import UIKit

// MARK: - ReusableCell

public protocol ReusableCell: AnyObject {
    associatedtype CellHolder: ReusableCellHolder
}

extension UITableViewCell: ReusableCell {
    public typealias CellHolder = UITableView
}

extension UICollectionViewCell: ReusableCell {
    public typealias CellHolder = UICollectionView
}

// MARK: - ReusableCellHolder

public protocol ReusableCellHolder: AnyObject {
    associatedtype CellType: ReusableCell where CellType.CellHolder == Self
    func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String)
    func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String)
    func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> CellType
    func cellForItem(at indexPath: IndexPath) -> CellType?
}

extension UITableView: ReusableCellHolder {

    public func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        register(nib, forCellReuseIdentifier: identifier)
    }

    public func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        register(cellClass, forCellReuseIdentifier: identifier)
    }

    public func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }

    public func cellForItem(at indexPath: IndexPath) -> UITableViewCell? {
        cellForRow(at: indexPath)
    }
}

extension UICollectionView: ReusableCellHolder {
}
