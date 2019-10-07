import UIKit
import Combine

final class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newButton: UIButton!
    var viewModel: ListViewModelType!
    var subscriptions = Set<AnyCancellable>()

    private let datasource = ListDataSource()


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = datasource
        datasource.tableView = tableView
        bind(viewModel.outputs)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.inputs.fetch()
    }

    private func bind(_ outputs: ListViewModelOutputsType) {
        outputs
            .addButtonLabel
            .sink(receiveValue: newButton.title)
            .store(in: &subscriptions)

        outputs
            .items
            .subscribe(datasource)
    }

    @IBAction func didPressAdd(_ sender: UIButton) {
        viewModel
            .inputs
            .add()
    }
}
