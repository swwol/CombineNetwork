import UIKit

protocol AppCoordinatorType: Coordinator {
 func start(on context: UINavigationController)
}

final class AppCoordinator: AppCoordinatorType {

    private let listCoordinator: ListCoordinatorType
    private let writeCoordinator: WriteCoordinatorType

    private weak var context: UINavigationController!

    init(repository: RepositoryType) {
        listCoordinator = ListCoordinator(repository: repository)
        writeCoordinator = WriteCoordinator(repository: repository)
        listCoordinator.delegate = self
        writeCoordinator.delegate = self
    }
    func start(on context: UINavigationController) {
        self.context = context
        listCoordinator.start(on: context, presentation: .cleanShow(animated: false))
    }
}

extension AppCoordinator: ListCoordinatorDelegate {
    func addItem(on coordinator: ListCoordinatorType) {
        writeCoordinator.start(on: context, presentation: .show(animated: true))
    }
}

extension AppCoordinator: WriteCoordinatorDelegate {
    func addedListItem( on: WriteCoordinatorType) {
        context.popViewController(animated: true)
    }
}
