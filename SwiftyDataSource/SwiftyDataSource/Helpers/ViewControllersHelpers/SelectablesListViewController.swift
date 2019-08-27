//
//  SelectablesListViewController.swift
//  launchOptions
//
//  Created by Alexey Bakhtin on 10/1/18.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

open class SelectablesListViewController<T>: UITableViewController, UISearchBarDelegate where T: SelectableEntity {

    // MARK: Public
    
    public init(container: DataSourceContainer<T>? = nil,
                selected: [T]? = nil,
                multiselection: Bool = false,
                cellUsesCustomSelection: Bool = false) {
        super.init(style: .plain)
        self.container = container
        self.dataSource.container = container
        self.selectedEntries = selected ?? []
        self.multiselection = multiselection
        self.cellUsesCustomSelection = cellUsesCustomSelection
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public var container: DataSourceContainer<T>? {
        didSet {
            self.dataSource.container = container
        }
    }
    
    public var delegate: AnySelectablesListDelegate<T>?
    public var didSelectAction: ((T) -> ())?

    open func cellIdentifier() -> String {
        return SelectablesListCell.defaultReuseIdentifier
    }
    
    open func registerCell() {
        tableView.registerCellClassForDefaultIdentifier(SelectablesListCell.self)
    }
    

    // MARK: Actions
    
    @objc private func done(_ sender: AnyObject) {
        delegate?.listDidSelect(self, entities: selectedEntries)
    }
    
    // MARK: View life cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        if multiselection {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done(_:)))
        }
        registerCell()
        dataSource.tableView = tableView
        tableView.allowsMultipleSelection = multiselection
        tableView.tableHeaderView = searchBar
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedEntries.forEach { selectedEntry in
            tableView.selectRow(at: container?.indexPath(for: selectedEntry), animated: false, scrollPosition: .none)
        }
    }
    
    // MARK: DataSource
    
    lazy var dataSource: TableViewDataSource<T> = {
        let dataSource = TableViewDataSource<T>(container: container, delegate: AnyTableViewDataSourceDelegate(self))
        dataSource.cellIdentifier = cellIdentifier()
        return dataSource
    }()
    
    // MARK: Private

    private var multiselection: Bool = false
    private var cellUsesCustomSelection: Bool = false
    private var selectedEntries: [T] = []
    private var allowTextSearch: Bool {
        return container is FilterableDataSourceContainer<T>
    }
    
    public var searchBar: UISearchBar? {
        if let searchBar = tableView.tableHeaderView as? UISearchBar {
            return searchBar
        }
        if allowTextSearch == false {
            return nil
        }
        
        let searchBar: UISearchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = NSLocalizedString("SEARCH", comment: "")
        searchBar.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60)
        return searchBar
    }

    @objc public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        (container as? FilterableDataSourceContainer)?.filterData(by: searchText)
        tableView.reloadData()
    }
    
}

extension SelectablesListViewController: TableViewDataSourceDelegate {
    public func dataSource(_ dataSource: DataSourceProtocol, didSelect object: T, at indexPath: IndexPath) {
        let index = selectedEntries.firstIndex(where: { $0.selectableEntityIsEqual(to: object)})
        if index == nil {
            didSelectAction?(object)
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
        
        if cellUsesCustomSelection == false {
            tableView.cellForRow(at: indexPath)?.accessoryType = isObjectSelected(object) ? .checkmark : .none
        }
    }
    
    public func dataSource(_ dataSource: DataSourceProtocol, accessoryTypeFor object: T, at indexPath: IndexPath)
        -> UITableViewCell.AccessoryType? {
        guard cellUsesCustomSelection == false else { return .none }
        return isObjectSelected(object) ? .checkmark : .none
    }
    
    private func isObjectSelected(_ object: T) -> Bool {
        return selectedEntries.contains(where: { $0.selectableEntityIsEqual(to: object) })
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
