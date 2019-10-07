import UIKit

struct CoordinatorFactory {
    func makeApp() -> AppCoordinatorType {
        let listStore = ListStore(store: UserDefaults.standard)
        return AppCoordinator(repository: Repository( store: listStore) )
    }
}
