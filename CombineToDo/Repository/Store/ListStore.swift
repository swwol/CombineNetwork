import Foundation

protocol ListStoreType {
    func getListItems() -> [ListItem]?
    func save(listItems: [ListItem]) throws
}

final class ListStore: ListStoreType {

    enum ListStoreError: Error {
        case saveError
    }

    let store: Persistable

    init(store: Persistable) {
        self.store = store
    }

    func getListItems() -> [ListItem]? {
        if let data = store.object(forKey: "Items") as? Data,
            let items = try? JSONDecoder().decode( [ListItem].self, from: data) {
            return items
        }
        return nil
    }

    func save(listItems: [ListItem]) throws {
        let encoder = JSONEncoder()

            guard let encoded = try? encoder.encode(listItems) else {
                throw ListStoreError.saveError
            }

           try store.set(encoded, forKey: "Items")
        }
    }
