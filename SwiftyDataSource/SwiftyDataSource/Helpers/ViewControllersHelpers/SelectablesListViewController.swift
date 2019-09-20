//
//  SelectablesListViewController.swift
//  launchOptions
//
//  Created by Alexey Bakhtin on 10/1/18.
//  Copyright © 2018 launchOptions. All rights reserved.
//

import UIKit

open class SelectablesListViewController<T>: UITableViewController, UISearchResultsUpdating where T: SelectableEntity {

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
    public var didSelectMultiAction: (([T]) -> ())?

    open func cellIdentifier() -> String {
        return SelectablesListCell.defaultReuseIdentifier
    }
    
    open func registerCell() {
        tableView.registerCellClassForDefaultIdentifier(SelectablesListCell.self)
    }
    

    // MARK: Actions
    
    @objc private func done(_ sender: AnyObject) {
        didSelectMultiAction?(selectedEntries)
        delegate?.listDidSelect(self, entities: selectedEntries)
    }
    
    // MARK: View life cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = multiselection
        registerCell()

        if multiselection {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done(_:)))
        }
        if container is FilterableDataSourceContainer {
            definesPresentationContext = true
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        }

        dataSource.tableView = tableView
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectRowsForSelectedEntries()
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
    
    public lazy var searchController: UISearchController? = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("FIND", comment: "")
        searchController.searchBar.setImage(UIImage(named: "searchbar-icon"), for: UISearchBar.Icon.search, state: .normal)
        searchController.searchBar.barStyle = .black
        searchController.searchBar.tintColor = .white
        
        return searchController
    }()

    fileprivate func selectRowsForSelectedEntries() {
        selectedEntries.forEach { entry in
            for section in 0..<tableView.numberOfSections {
                for row in 0..<tableView.numberOfRows(inSection: section) {
                    let indexPath = IndexPath(row: row, section: section)
                    let entity = (tableView.cellForRow(at: indexPath) as? SelectablesListCell)?.entity
                    let selected = entity?.selectableEntityIsEqual(to: entry) == true
                    if selected {
                        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                }
            }
        }
    }

    // MARK: UISearchResultsUpdating
    
    public func updateSearchResults(for searchController: UISearchController) {
        (container as? FilterableDataSourceContainer)?.filterData(by: searchController.searchBar.text)
        tableView.reloadData()
        selectRowsForSelectedEntries()
    }

}

extension SelectablesListViewController: TableViewDataSourceDelegate {
    public func dataSource(_ dataSource: DataSourceProtocol, didSelect object: T, at indexPath: IndexPath) {
        let index = selectedEntries.firstIndex(where: { $0.selectableEntityIsEqual(to: object)})
        if index == nil {
            didSelectAction?(object)
            selectedEntries.append(object)
        }

        // No need to call delegate didSelect: if multiselection is enabled
        if isObjectSelected(object) {
            delegate?.listDidSelect(self, object)
        }
    }
    
    public func dataSource(_ dataSource: DataSourceProtocol, didDeselect object: T, at indexPath: IndexPath?) {
        if let index = selectedEntries.firstIndex(where: { $0.selectableEntityIsEqual(to: object)}) {
            selectedEntries.remove(at: index)
            delegate?.listDidDeselect(self, object)
        }
    }
    
    private func isObjectSelected(_ object: T) -> Bool {
        return selectedEntries.contains(where: { $0.selectableEntityIsEqual(to: object) })
    }
}

open class SelectablesListCell: UITableViewCell, DataSourceConfigurable {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    public let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    open func setup() {
        contentView.addSubview(label)
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 15).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
    }
    
    public func configure(with object: Any) {
        self.entity = object as? SelectableEntity
    }
    
    open var entity: SelectableEntity? {
        didSet {
            label.attributedText = entity?.selectableEntityDescription
        }
    }
}
