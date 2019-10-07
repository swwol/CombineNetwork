import UIKit

protocol WriteCoordinatorType: Coordinator {
    func start(on context: UINavigationController,
                 presentation: PresentationStyle)
}

final class WriteCoordinator: WriteCoordinatorType {
    func start(on context: UINavigationController, presentation: PresentationStyle) {
        let viewController: WriteViewController = .fromStoryboard()
        let viewModel = WriteViewModel()
        viewController.viewModel = viewModel
        present(viewController, style: presentation, on: context)
    }
}
