import UIKit


protocol ListCoordinatorType: Coordinator {
    func start(on context: UINavigationController,
                 presentation: PresentationStyle)
    var delegate: ListCoordinatorDelegate? { get set }
}

protocol ListCoordinatorDelegate: AnyObject {
    func addItem(on coordinator: ListCoordinatorType)
}

final class ListCoordinator: ListCoordinatorType {
    private let repository: RepositoryType

    init(repository: RepositoryType) {
        self.repository = repository
    }

    weak var delegate: ListCoordinatorDelegate?

    func start(on context: UINavigationController, presentation: PresentationStyle) {
        let viewController: ListViewController = .fromStoryboard()
        let viewModel = ListViewModel(repository: repository)
        viewModel.delegate = self
        viewController.viewModel = viewModel
        present(viewController, style: presentation, on: context)
    }
}

extension ListCoordinator: ListViewModelDelegate {

    func addPressed(on viewModel: ListViewModelType) {
        delegate?.addItem(on: self)
    }
}


