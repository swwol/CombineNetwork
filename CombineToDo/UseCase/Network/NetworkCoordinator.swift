import UIKit

protocol NetworkCoordinatorType: Coordinator {
    func start(on context: UINavigationController,
                 presentation: PresentationStyle)
}


final class NetworkCoordinator: NetworkCoordinatorType {

    let networkRepository = NetworkRepository()
    func start(on context: UINavigationController, presentation: PresentationStyle) {
        let viewController: NetworkViewController = .fromStoryboard()
        let viewModel = NetworkViewModel(networkRepository: networkRepository)
        viewController.viewModel = viewModel
        present(viewController, style: presentation, on: context)
    }
}
