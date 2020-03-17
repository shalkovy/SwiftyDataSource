# SwiftyDataSource

### there are two main abstractions in library:

1. Container *helps work with information and can handle data*
2. Data Source *abstraction, which include **container** and displays data from container*

## Containers

1. ### ArrayDataSourceContainer

```swift
func insert(object: ResultType, at indexPath: IndexPath) { }
func remove(at indexPath: IndexPath) throws { }
func replace(object: ResultType, at indexPath: IndexPath, reloadAction: Bool = false) { }
```
