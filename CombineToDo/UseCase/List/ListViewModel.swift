import UIKit
import Combine

typealias ListViewModelTypeAndDataSourceDelegate = ListViewModelType & ListDataSourceDelegate

protocol ListViewModelType {
    var inputs: ListViewModelInputsType { get }
    var outputs: ListViewModelOutputsType { get }
    var delegate: ListViewModelDelegate? { get set }
}

protocol ListViewModelInputsType {
    func add()
    func fetch()
    func toggleItem(index: Int)
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
    private let itemsPublisher: CurrentValueSubject<[ListItem], Never>
    private let repository: RepositoryType

    init(repository: RepositoryType) {
        addButtonLabelPublisher = Just("Add")
        itemsPublisher = CurrentValueSubject<[ListItem], Never>([])
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

    func toggleItem(index: Int) {
        var items = itemsPublisher.value
        items[index].done = !items[index].done
        itemsPublisher.send(items)
    }
}

extension ListViewModel: ListDataSourceDelegate {
    func sync(items: [ListItem], on: ListDataSource) {
        do {
            try repository.saveItems(items: items)
        } catch let error {
            print (error)
        }
    }
}
