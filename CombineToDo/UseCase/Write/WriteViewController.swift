import UIKit
import Combine

final class WriteViewController: UIViewController {

    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var field: UITextField!

    var viewModel: WriteViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = NotificationCenter
            .default
            .didChange(textField: field) { string in
                self.viewModel.inputs.fieldUpdated(with: string)
        }

            bind(viewModel.outputs)
    }

    private func bind(_ outputs: WriteViewModelOutputsType) {

        _ =  viewModel
            .outputs
            .isEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: submitButton)

        _ =  viewModel
            .outputs
            .buttonLabel
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: submitButton.title)

    }
}


