import Foundation
import Combine

protocol RepositoryType {
    func getItems() -> Future<[ListItem]?, Never>
    func saveItems(items: [ListItem]) throws
    func addItem(item: ListItem) throws
}

final class Repository: RepositoryType {

    let store: ListStoreType

    init(store: ListStoreType) {
        self.store = store
    }

    func getItems() -> Future<[ListItem]?, Never>  {
        return Future<[ListItem]?, Never> { promise in
            promise(.success(self.store.getListItems()))
        }
    }

    func saveItems(items: [ListItem]) throws {
        try store.save(listItems: items )
    }

    func addItem(item: ListItem) {
        _ = getItems().sink(receiveValue: { items in
            do {
                if let items = items {
                    try self.saveItems(items: items + [item])
                } else {
                    try self.saveItems(items: [item])
                }
            } catch let error {
                print ( error)
            }
        })
    }
}
