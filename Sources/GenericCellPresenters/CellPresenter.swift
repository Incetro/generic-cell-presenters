//
//  CellPresenter.swift
//  AppName
//
//  Created by incetro on 03/04/2018.
//  Copyright © 2018 incetro. All rights reserved.
//

import UIKit

// MARK: - CellPresenter

open class CellPresenter<T: ReusableCellHolder>: NSObject {

    // MARK: - Properties

    /// Current cell's reusable holder
    public weak var reusableCellHolder: T?

    /// Current cell's indexPath value
    public var indexPath: IndexPath?

    // MARK: - Initializers

    public override init() {
    }

    // MARK: - Class

    /// Must return current cell class type
    open class var cellClass: AnyClass {
        fatalError("Must be overriden by children.")
    }

    // MARK: - Static

    /// Cell's reuse identifier
    public static var cellIdentifier: String {
        String(describing: cellClass)
    }

    /// Register cell on the given reusable holder
    /// - Parameter reusableCellHolder: current cell's reusable holder
    public static func registerCell(on reusableCellHolder: T) {
        let bundle = Bundle(for: cellClass)
        if bundle.path(forResource: cellIdentifier, ofType: "nib") != nil {
            let nib = UINib(nibName: cellIdentifier, bundle: bundle)
            reusableCellHolder.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        } else {
            reusableCellHolder.register(cellClass, forCellWithReuseIdentifier: cellIdentifier)
        }
    }

    // MARK: - Useful

    /// If you want to create Cell without dequeueing you can use
    /// this factory method and implement your own logic of obtaining cell
    /// - Returns: a new cell instance
    open func cellFactory() -> T.CellType? {
        nil
    }

    /// Dequeue a new reusable cell
    /// - Parameters:
    ///   - reusableCellHolder: current cell's reusable holder
    ///   - indexPath: supposed indexPath for necessary cell
    /// - Returns: dequeued cell instance
    final public func cellFromReusableCellHolder(
        _ reusableCellHolder: T,
        forIndexPath indexPath: IndexPath
    ) -> T.CellType {
        self.reusableCellHolder = reusableCellHolder
        self.indexPath = indexPath
        let cell = cellFactory() ?? reusableCellHolder.dequeueReusableCell(
            withReuseIdentifier: type(of: self).cellIdentifier,
            for: indexPath
        )
        configureCell(cell)
        return cell
    }

    /// Returns a cell instance for the current presenter
    /// - Returns: a cell instance for the current presenter
    final public func innerCurrentCell() -> T.CellType? {
        guard let indexPath = indexPath else {
            return nil
        }
        return reusableCellHolder?.cellForItem(at: indexPath)
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
    open func configureCell(_ cell: T.CellType) {
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
    open func willDisplayCell(_ cell: T.CellType) {
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
    open func didEndDisplayingCell(_ cell: T.CellType) {
    }

    /// `didSelectCell` delegate method
    ///
    /// Example in a cell presenter subclass:
    ///
    ///     override func didSelectCell() {
    ///         viewModel.isSelected = true
    ///         updateCellSelection()
    ///     }
    ///
    /// Will be called after `didSelectRowAt` implementation:
    ///
    ///     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    ///         controllers[indexPath.row].didSelectCell()
    ///     }
    ///
    open func didSelectCell() {
    }

    /// `didDeselectCell` delegate method
    ///
    /// Example in a cell presenter subclass:
    ///
    ///     override func didDeselectCell() {
    ///         viewModel.isSelected = false
    ///         updateCellSelection()
    ///     }
    ///
    /// Will be called after `didDeselectRowAt` implementation:
    ///
    ///     func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    ///         controllers[indexPath.row].didDeselectCell()
    ///     }
    ///
    open func didDeselectCell() {
    }

    /// `shouldHighlightRowAt` delegate method
    ///
    /// Example in a cell presenter subclass:
    ///
    ///     override func shouldHighlightCell() -> Bool {
    ///         viewModel.isHighlightable
    ///     }
    ///
    /// Will be called after `shouldHighlightRowAt` implementation:
    ///
    ///     func tableView(
    ///         _ tableView: UITableView,
    ///         shouldHighlightRowAt indexPath: IndexPath
    ///     ) -> Bool {
    ///         controllers[indexPath.row].shouldHighlightCell()
    ///     }
    ///
    open func shouldHighlightCell() -> Bool {
        true
    }

    /// `didHighlightRowAt` delegate method
    ///
    /// Example in a cell presenter subclass:
    ///
    ///     override func didHighlightCell() {
    ///         currentCell()?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.38)
    ///     }
    ///
    /// Will be called after `didHighlightRowAt` implementation:
    ///
    ///     func tableView(
    ///         _ tableView: UITableView,
    ///         didHighlightRowAt indexPath: IndexPath
    ///     ) {
    ///         controllers[indexPath.row].didHighlightCell()
    ///     }
    ///
    open func didHighlightCell() {
    }

    /// `didUnhighlightRowAt` delegate method
    ///
    /// Example in a cell presenter subclass:
    ///
    ///     override func didUnhighlightCell() {
    ///         currentCell()?.backgroundColor = .clear
    ///     }
    ///
    /// Will be called after `didUnhighlightRowAt` implementation:
    ///
    ///     func tableView(
    ///         _ tableView: UITableView,
    ///         didUnhighlightRowAt indexPath: IndexPath
    ///     ) {
    ///         controllers[indexPath.row].didUnhighlightCell()
    ///     }
    ///
    open func didUnhighlightCell() {
    }

    /// Calculates current cell size
    ///
    ///     override func cellSize(reusableCellHolder: UITableView) -> CGSize {
    ///         CGSize(
    ///             width: reusableCellHolder.frame.width,
    ///             height: UITableView.automaticDimension
    ///         )
    ///     }
    ///
    /// Can be called inside `heightForRowAt` implementation:
    ///
    ///     func tableView(
    ///         _ tableView: UITableView,
    ///         heightForRowAt indexPath: IndexPath
    ///     ) -> CGFloat {
    ///         controllers[indexPath.row]
    ///             .cellSize(reusableCellHolder: tableView).height
    ///     }
    ///
    /// - Parameter reusableCellHolder: current cell's indexPath value
    /// - Returns: current cell size
    open func cellSize(reusableCellHolder: T) -> CGSize {
        fatalError("Must be overriden by children.")
    }

    /// Calculates current cell estimated size
    ///
    ///     override func estimatedCellSize(reusableCellHolder: UITableView) -> CGSize {
    ///         CGSize(
    ///             width: reusableCellHolder.frame.width,
    ///             height: 53
    ///         )
    ///     }
    ///
    /// Can be called inside `heightForRowAt` implementation:
    ///
    ///     func tableView(
    ///         _ tableView: UITableView,
    ///         estimatedHeightForRowAt indexPath: IndexPath
    ///     ) -> CGFloat {
    ///         controllers[indexPath.row]
    ///             .estimatedCellSize(reusableCellHolder: tableView).height
    ///     }
    ///
    /// - Parameter reusableCellHolder: current cell's indexPath value
    /// - Returns: current cell size
    open func estimatedCellSize(reusableCellHolder: T) -> CGSize {
        fatalError("Must be overriden by children.")
    }
}
