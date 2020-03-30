# SwiftyDataSource

### there are two main abstractions in library:

1. Container *helps work with information and can handle data*
2. Data Source *abstraction, which include **container** and displays data from container*

## Containers

1. ### ArrayDataSourceContainer

used with arrays data

```swift
func insert(object: ResultType, at indexPath: IndexPath) throws { }
func remove(at indexPath: IndexPath) throws { }
func replace(object: ResultType, at indexPath: IndexPath, reloadAction: Bool = false) throws { }
func removeAll() { }
```
2. ### FRCDataSourceContainer

used with data from fetch result controller

```swift
var fetchedObjects: [ResultType]
func object(at indexPath: IndexPath) -> ResultType? { }
func search(_ block:(IndexPath, ResultType) -> Bool) { }
func indexPath(for object: ResultType) -> IndexPath? { }
```
3. ### FilterableDataSourceContainer

```swift
func filterData(by searchText: String?) { }
func numberOfItems(in section: Int) -> Int? { }
func object(at indexPath: IndexPath) -> T? { }
```

## DataSources

1. ### CollectionViewDataSource (use with **CollectionViewDataSourceDelegate**)

2. ### TableViewDataSource (use with **TableViewDataSourceDelegate**)

```swift
func dataSource(_ dataSource: DataSourceProtocol, cellIdentifierFor object: ObjectType, at indexPath: IndexPath) -> String?
func dataSource(_ dataSource: DataSourceProtocol, accessoryTypeFor object: ObjectType, at indexPath: IndexPath) -> UITableViewCell.AccessoryType?
func dataSource(_ dataSource: DataSourceProtocol, didSelect object: ObjectType, at indexPath: IndexPath)
func dataSource(_ dataSource: DataSourceProtocol, didDeselect object: ObjectType, at indexPath: IndexPath?)
```

3. ### MapViewDataSource (use with **MapViewDataSourceDelegate**)
```swift
func dataSource(_ dataSource: DataSourceProtocol, didSelect object: ObjectType) { }
```

**all DataSources have property noDataView which is show, when there are no data in containers**


## code example with FRCDataSourceContainer and tableView

> View Controller properties

```swift
var container: FRCDataSourceContainer<ClassType>?

@IBOutlet weak var tableView: UITableView! {
didSet {
    dataSource.tableView = tableView
    tableView.registerCellNibForDefaultIdentifier(TableViewCell.self)
    dataSource.noDataView = NoDataView()
}

private lazy var dataSource: TableViewDataSource<ClassType> = {
    let dataSource = TableViewDataSource<ClassType>(delegate: AnyTableViewDataSourceDelegate(self))
    dataSource.cellIdentifier = TableViewCell.defaultReuseIdentifier
    return dataSource
}()
```
> View Controller methods

```swift
extension ViewController: TableViewDataSourceDelegate {
    typealias ObjectType = ClassType
    func dataSource(_ dataSource: DataSourceProtocol, didSelect object: ClassType, at indexPath: IndexPath) { }
}
```
