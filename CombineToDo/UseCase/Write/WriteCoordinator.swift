import UIKit

protocol WriteCoordinatorType: Coordinator {
    func start(on context: UINavigationController,
               presentation: PresentationStyle)
    var delegate: WriteCoordinatorDelegate? { get set }
}

protocol WriteCoordinatorDelegate: AnyObject {
    func addedListItem(on: WriteCoordinatorType)
}

final class WriteCoordinator: WriteCoordinatorType {

    weak var delegate: WriteCoordinatorDelegate?
    private let repository: RepositoryType

    init(repository: RepositoryType) {
        self.repository = repository
    }

    func start(on context: UINavigationController, presentation: PresentationStyle) {
        let viewController: WriteViewController = .fromStoryboard()
        let viewModel = WriteViewModel(repository: repository)
        viewModel.delegate = self
        viewController.viewModel = viewModel
        present(viewController, style: presentation, on: context)
    }
}

extension WriteCoordinator: WriteViewModelDelegate {
    func addedListItem(on: WriteViewModelType) {
        delegate?.addedListItem(on: self)
    }
}
