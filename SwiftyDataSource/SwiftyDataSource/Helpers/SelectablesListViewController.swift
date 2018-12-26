//
//  SelectablesListViewController.swift
//  HRketing
//
//  Created by Aleksey Bakhtin on 12/20/17.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit
//import SwiftyDataSource
//import RxSwift

public protocol SelectablesListDelegate {
    associatedtype T: SelectableEntity
    func listDidSelect(_ list: SelectablesListViewController<T>, _ entity: T)
    func listDidSelect(_ list: SelectablesListViewController<T>, entities: [T])
    func listDidDeselect(_ list: SelectablesListViewController<T>, _ entity: T)
}

public extension SelectablesListDelegate {
    func listDidSelect(_ list: SelectablesListViewController<T>, entities: [T]) { }
    func listDidDeselect(_ list: SelectablesListViewController<T>, _ entity: T) { }
}

public class AnySelectablesListDelegate<T>: SelectablesListDelegate where T: SelectableEntity {
    public required init<U: SelectablesListDelegate>(_ delegate: U) where U.T == T {
        _listDidSelectEntity = delegate.listDidSelect
        _listDidDeselectEntity = delegate.listDidDeselect
        _listDidSelectEntities = delegate.listDidSelect
    }
    
    private let _listDidSelectEntity: (SelectablesListViewController<T>, T) -> Void
    private let _listDidDeselectEntity: (SelectablesListViewController<T>, T) -> Void
    private let _listDidSelectEntities: (SelectablesListViewController<T>, [T]) -> Void
    
    public func listDidSelect(_ list: SelectablesListViewController<T>, _ entity: T) {
        return _listDidSelectEntity(list, entity)
    }
    public func listDidSelect(_ list: SelectablesListViewController<T>, entities: [T]) {
        return _listDidSelectEntities(list, entities)
    }
    public func listDidDeselect(_ list: SelectablesListViewController<T>, _ entity: T) {
        return _listDidDeselectEntity(list, entity)
    }
}

public protocol SelectableEntity {
    var selectableEntityDescription: NSAttributedString { get }
    func selectableEntityIsEqual(to: SelectableEntity) -> Bool
}

open class SelectablesListViewController<T>: UITableViewController where T: SelectableEntity {

    // MARK: Public
    
    public required init(container: DataSourceContainer<T>? = nil,
                selected: [T]? = nil,
                multiselection: Bool = false) {
        super.init(style: .plain)
        self.container = container
        self.dataSource.container = container
        self.selectedEntries = selected ?? []
        self.multiselection = multiselection
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var container: DataSourceContainer<T>? {
        didSet {
            self.dataSource.container = container
        }
    }
    
    public var delegate: AnySelectablesListDelegate<T>?
    
//    public var selectedEntry = Variable<T?>(nil)

    // MARK: Actions
    
    @objc
    private func done(sender: AnyObject) {
        delegate?.listDidSelect(self, entities: selectedEntries)
    }
    
    // MARK: View life cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        if multiselection {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done(sender:)))
        }
        registerCell()
        dataSource.tableView = tableView
    }

    open func cellIdentifier() -> String {
        return SelectablesListCell.defaultReuseIdentifier
    }

    open func registerCell() {
        tableView.registerCellClassForDefaultIdentifier(SelectablesListCell.self)
    }
    
    // MARK: DataSource
    
    lazy var dataSource: TableViewDataSource<T> = {
        let dataSource = TableViewDataSource<T>(tableView: nil, cellIdentifier: nil, container: container, delegate: AnyTableViewDataSourceDelegate(self))
        dataSource.cellIdentifier = cellIdentifier()
        return dataSource
    }()
    
    // MARK: Private

    private var multiselection: Bool = false
    private var selectedEntries: [T] = []
}

extension SelectablesListViewController: TableViewDataSourceDelegate {
    public func dataSource(_ dataSource: DataSourceProtocol, didSelect object: T, at indexPath: IndexPath) {
        let index = selectedEntries.firstIndex(where: { $0.selectableEntityIsEqual(to: object)})
        if index == nil {
//            selectedEntry.value = object
            selectedEntries.append(object)
        } else if multiselection, let indexExp = index {
            selectedEntries.remove(at: indexExp)
        }

        // No need to call delegate didSelect: if multiselection is enabled
        if !multiselection || isObjectSelected(object) {
            delegate?.listDidSelect(self, object)
        } else {
            delegate?.listDidDeselect(self, object)
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = isObjectSelected(object) ? .checkmark : .none
    }
    
    public func dataSource(_ dataSource: DataSourceProtocol, accessoryTypeFor object: T, at indexPath: IndexPath) -> UITableViewCell.AccessoryType? {
        return isObjectSelected(object) ? .checkmark : .none
    }
    
    private func isObjectSelected(_ object: T) -> Bool {
        return selectedEntries.contains(where: { $0.selectableEntityIsEqual(to: object)})
    }
}

open class SelectablesListCell: UITableViewCell, DataSourceConfigurable {
    
    public let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        contentView.addSubview(label)
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 15).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
    }
    
    public func configure(with object: Any) {
        self.entity = object as? SelectableEntity
    }
    
    private var entity: SelectableEntity? {
        didSet {
            label.attributedText = entity?.selectableEntityDescription
        }
    }
}
