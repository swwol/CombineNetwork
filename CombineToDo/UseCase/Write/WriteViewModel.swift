import UIKit
import Combine

protocol WriteViewModelType {
    var inputs: WriteViewModelInputsType { get }
    var outputs: WriteViewModelOutputsType { get }
    var delegate: WriteViewModelDelegate? { get set }
}

protocol WriteViewModelInputsType {
    func fieldUpdated(with text: String?)
    func addListItem(text: String)
}

protocol WriteViewModelOutputsType {
    var isEnabled: AnyPublisher<Bool, Never> { get }
    var buttonLabel: AnyPublisher<String?, Never> { get }
}

protocol WriteViewModelDelegate: AnyObject {
    func addedListItem(on: WriteViewModelType)
}

final class WriteViewModel: WriteViewModelType, WriteViewModelInputsType, WriteViewModelOutputsType {

    var inputs: WriteViewModelInputsType { return self }
    var outputs: WriteViewModelOutputsType { return self }

    weak var delegate: WriteViewModelDelegate?

    private let enabledPublisher: CurrentValueSubject<Bool, Never>
    private let buttonLabelPublisher: Just<String?>
    private let repository: RepositoryType

    var isEnabled: AnyPublisher<Bool, Never> {
        return enabledPublisher
            .eraseToAnyPublisher()
    }
    var buttonLabel: AnyPublisher<String?, Never> {
        return buttonLabelPublisher
        .eraseToAnyPublisher()
    }

    init(repository: RepositoryType) {
        self.repository = repository
        enabledPublisher = CurrentValueSubject<Bool, Never>(false)
        buttonLabelPublisher = Just("Submit")
    }

    func fieldUpdated(with text: String?) {
        enabledPublisher.send(text != nil && text != "")
    }

    func addListItem(text: String) {
        do {
            try repository.addItem(item: ListItem(item: text, done: false))
        } catch let error {
            print (error)
        }
        delegate?.addedListItem( on: self)
    }
}

