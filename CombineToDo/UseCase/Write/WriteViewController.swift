import UIKit
import Combine

final class WriteViewController: UIViewController {

    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var field: UITextField!

    var viewModel: WriteViewModelType!
    var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter
            .default
            .didChange(textField: field) { string in
                self.viewModel.inputs.fieldUpdated(with: string)
        }
        .store(in: &subscriptions)

        bind(viewModel.outputs)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        subscriptions.forEach { $0.cancel() }
    }

    private func bind(_ outputs: WriteViewModelOutputsType) {
        outputs
            .isEnabled
            .assign(to: \.isEnabled, on: submitButton)
            .store(in: &subscriptions)

        outputs
            .buttonLabel
            .sink(receiveValue: submitButton.title)
            .store(in: &subscriptions)
    }
    @IBAction func submitPressed(_ sender: UIButton) {

        guard let text = field.text else { return }
        viewModel
            .inputs
            .addListItem(text: text)
    }
}


