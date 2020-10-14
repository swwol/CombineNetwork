import UIKit
import Combine

final class NetworkViewController: UIViewController {

    var viewModel: NetworkViewModelType!
    var cancellables =  Set<AnyCancellable>()
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBAction func didPressStart(_ sender: UIButton) {

        print("start network request")
        viewModel.inputs.didPressStart()
    }

    override func viewDidLoad() {

        bind(viewModel.outputs)

    /*    viewModel
            .$body
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: bodyLabel)
            .store(in: &cancellables)
        viewModel
            .$title
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: titleLabel)
            .store(in: &cancellables)*/
    }

    private func bind(_ outputs: NetworkViewModelOutputsType) {

        outputs
            .bodyPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: bodyLabel)
            .store(in: &cancellables)

        outputs
            .titlePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: titleLabel)
            .store(in: &cancellables)

    }

}
