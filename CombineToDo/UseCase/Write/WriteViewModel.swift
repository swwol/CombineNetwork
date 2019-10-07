import UIKit
import Combine

protocol WriteViewModelType {
    var inputs: WriteViewModelInputsType { get }
    var outputs: WriteViewModelOutputsType { get }
}

protocol WriteViewModelInputsType {

    func fieldUpdated(with text: String?)

}

protocol WriteViewModelOutputsType {
    var isEnabled: AnyPublisher<Bool, Never> { get }
    var buttonLabel: AnyPublisher<String?, Never> { get }
}

final class WriteViewModel: WriteViewModelType, WriteViewModelInputsType, WriteViewModelOutputsType {

    var inputs: WriteViewModelInputsType { return self }
    var outputs: WriteViewModelOutputsType { return self }

    private let enabledPublisher: CurrentValueSubject<Bool, Never>
    private let buttonLabelPublisher: Just<String?>

    var isEnabled: AnyPublisher<Bool, Never> {
        return enabledPublisher
            .eraseToAnyPublisher()
    }
    var buttonLabel: AnyPublisher<String?, Never> {
        return buttonLabelPublisher
        .eraseToAnyPublisher()
    }

    init() {
        enabledPublisher = CurrentValueSubject<Bool, Never>(false)
        buttonLabelPublisher = Just("Submit")
    }

    func fieldUpdated(with text: String?) {
        enabledPublisher.send(text != nil && text != "")
    }
}

