import UIKit

protocol AppCoordinatorType: Coordinator {
 func start(on context: UINavigationController)
}

final class AppCoordinator: AppCoordinatorType {
    private let networkCoordinator: NetworkCoordinator

    private weak var context: UINavigationController!

    init() {
        networkCoordinator = NetworkCoordinator()
    }
    func start(on context: UINavigationController) {
        self.context = context
        networkCoordinator.start(on: context, presentation: .cleanShow(animated: false))
    }
}
