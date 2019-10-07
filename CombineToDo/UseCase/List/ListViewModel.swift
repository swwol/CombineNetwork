import UIKit
import Combine

protocol ListViewModelType {
    var inputs: ListViewModelInputsType { get }
    var outputs: ListViewModelOutputsType { get }
    var delegate: ListViewModelDelegate? { get set }
}

protocol ListViewModelInputsType {
    func add()
    func fetch()
}

protocol ListViewModelDelegate: AnyObject {
    func addPressed(on viewModel: ListViewModelType)
}

protocol ListViewModelOutputsType {
    var addButtonLabel: AnyPublisher<String?, Never> { get }
    var items: AnyPublisher<[ListItem], Never> { get }
}

final class ListViewModel: ListViewModelType, ListViewModelInputsType, ListViewModelOutputsType {
    var delegate: ListViewModelDelegate?

    var inputs: ListViewModelInputsType {
        return self
    }

    var outputs: ListViewModelOutputsType {
        return self
    }

    private let addButtonLabelPublisher: Just<String?>
    private let itemsPublisher: PassthroughSubject<[ListItem], Never>
    private let repository: RepositoryType

    init(repository: RepositoryType) {
        addButtonLabelPublisher = Just("Add")
        itemsPublisher = PassthroughSubject<[ListItem], Never>()
        self.repository = repository
    }

    var addButtonLabel: AnyPublisher<String?, Never> {
           return addButtonLabelPublisher
           .eraseToAnyPublisher()
       }

    var items: AnyPublisher<[ListItem], Never> {
        return itemsPublisher
            .eraseToAnyPublisher()
    }

    func add() {
        delegate?.addPressed(on: self)
    }

    func fetch() {
        _ = repository.getItems().sink(receiveValue: { items in
            if let items = items {
                self.itemsPublisher.send(items)
            }
        })
    }
}
