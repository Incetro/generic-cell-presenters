//
//  GenericCellPresenter.swift
//  AppName
//
//  Created by incetro on 03/04/2018.
//  Copyright © 2018 incetro. All rights reserved.
//

import UIKit

// MARK: - GenericCellPresenter

open class GenericCellPresenter<T: ReusableCell>: CellPresenter<T.CellHolder> {

    /// Must return current cell class type
    final override public class var cellClass: AnyClass {
        T.self
    }

    /// Configuration method
    ///
    /// Example in a cell presenter subclass:
    ///
    ///     override func configureCell(_ cell: CountryCell) {
    ///         cell.setup(with: viewModel)
    ///     }
    ///
    /// Will be called automatically after `cellForRowAt` implementation:
    ///
    ///     func tableView(
    ///         _ tableView: UITableView,
    ///         cellForRowAt indexPath: IndexPath
    ///     ) -> UITableViewCell {
    ///         let cell = controllers[indexPath.row]
    ///             .cellFromReusableCellHolder(tableView, forIndexPath: indexPath) as? CountryCell
    ///         cell?.selectionStyle = .none
    ///         return cell.unwrap()
    ///     }
    ///
    /// - Parameter cell: some cell
    final override public func configureCell(_ cell: T.CellHolder.CellType) {
        guard let cell = cell as? T else {
            fatalError("Cell of \(T.CellHolder.CellType.self) must be \(T.self)")
        }
        configureCell(cell)
    }

    /// Returns a type-erased cell instance for the current presenter
    /// - Returns: a type-erased cell instance for the current presenter
    final public func currentCell() -> T? {
        innerCurrentCell() as? T
    }

    /// `willDisplay` delegate method
    ///
    /// Example in a cell presenter subclass:
    ///
    ///     override func willDisplayCell(_ cell: RouteInfoCell) {
    ///         userLocationServiceObservable.add(observer: cell) { coordinate in
    ///             let distance = CLLocation.distance(
    ///                 from: coordinate.cllocationCoordinate,
    ///                 to: targetCoordinate.cllocationCoordinate
    ///             )
    ///             cell.update(meters: Int(distance.toStartRadiusTrimmed))
    ///         }
    ///     }
    ///
    /// Will be called after `willDisplay` implementation:
    ///
    ///     func tableView(
    ///         _ tableView: UITableView,
    ///         willDisplay cell: UITableViewCell,
    ///         forRowAt indexPath: IndexPath
    ///     ) {
    ///         controllers[indexPath.row]?.willDisplayCell(cell)
    ///     }
    ///
    /// - Parameter cell: some cell
    final override public func willDisplayCell(_ cell: T.CellHolder.CellType) {
        if let cell = cell as? T {
            willDisplayCell(cell)
        }
    }

    /// `didEndDisplaying` delegate method
    ///
    /// Example in a cell presenter subclass:
    ///
    ///     override func didEndDisplayingCell(_ cell: RouteInfoCell) {
    ///         userLocationServiceObservable.remove(observer: cell)
    ///     }
    ///
    /// Will be called after `didEndDisplaying` implementation:
    ///
    ///     func tableView(
    ///         _ tableView: UITableView,
    ///         didEndDisplaying cell: UITableViewCell,
    ///         forRowAt indexPath: IndexPath
    ///     ) {
    ///         controllers[indexPath.row]?.didEndDisplayingCell(cell)
    ///     }
    ///
    /// - Parameter cell: some cell
    final override public func didEndDisplayingCell(_ cell: T.CellHolder.CellType) {
        if let cell = cell as? T {
            didEndDisplayingCell(cell)
        }
    }

    /// Configuration method
    ///
    /// Example in a cell presenter subclass:
    ///
    ///     override func configureCell(_ cell: CountryCell) {
    ///         cell.setup(with: viewModel)
    ///     }
    ///
    /// Will be called automatically after `cellForRowAt` implementation:
    ///
    ///     func tableView(
    ///         _ tableView: UITableView,
    ///         cellForRowAt indexPath: IndexPath
    ///     ) -> UITableViewCell {
    ///         let cell = controllers[indexPath.row]
    ///             .cellFromReusableCellHolder(tableView, forIndexPath: indexPath) as? CountryCell
    ///         cell?.selectionStyle = .none
    ///         return cell.unwrap()
    ///     }
    ///
    /// - Parameter cell: some cell
    open func configureCell(_ cell: T) {
    }

    /// `willDisplay` delegate method
    ///
    /// Example in a cell presenter subclass:
    ///
    ///     override func willDisplayCell(_ cell: RouteInfoCell) {
    ///         userLocationServiceObservable.add(observer: cell) { coordinate in
    ///             let distance = CLLocation.distance(
    ///                 from: coordinate.cllocationCoordinate,
    ///                 to: targetCoordinate.cllocationCoordinate
    ///             )
    ///             cell.update(meters: Int(distance.toStartRadiusTrimmed))
    ///         }
    ///     }
    ///
    /// Will be called after `willDisplay` implementation:
    ///
    ///     func tableView(
    ///         _ tableView: UITableView,
    ///         willDisplay cell: UITableViewCell,
    ///         forRowAt indexPath: IndexPath
    ///     ) {
    ///         controllers[indexPath.row]?.willDisplayCell(cell)
    ///     }
    ///
    /// - Parameter cell: some cell
    open func willDisplayCell(_ cell: T) {
    }

    /// `didEndDisplaying` delegate method
    ///
    /// Example in a cell presenter subclass:
    ///
    ///     override func didEndDisplayingCell(_ cell: RouteInfoCell) {
    ///         userLocationServiceObservable.remove(observer: cell)
    ///     }
    ///
    /// Will be called after `didEndDisplaying` implementation:
    ///
    ///     func tableView(
    ///         _ tableView: UITableView,
    ///         didEndDisplaying cell: UITableViewCell,
    ///         forRowAt indexPath: IndexPath
    ///     ) {
    ///         controllers[indexPath.row]?.didEndDisplayingCell(cell)
    ///     }
    ///
    /// - Parameter cell: some cell
    open func didEndDisplayingCell(_ cell: T) {
    }
}

// MARK: - Aliases

public typealias TableCellPresenter = CellPresenter<UITableView>
public typealias CollectionCellPresenter = CellPresenter<UICollectionView>
