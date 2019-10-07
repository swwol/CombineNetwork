import UIKit

protocol AppCoordinatorType: Coordinator {
 func start(on context: UINavigationController)
}

final class AppCoordinator: AppCoordinatorType {

    private let writeCoordinator: WriteCoordinatorType

    init() {
        writeCoordinator = WriteCoordinator()
    }
    func start(on context: UINavigationController) {
        writeCoordinator.start(on: context, presentation: .cleanShow(animated: false))
    }
}
