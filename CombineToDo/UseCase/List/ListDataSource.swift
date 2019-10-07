import UIKit
import Combine

final class ListDataSource: NSObject, UITableViewDataSource, Subscriber {

    typealias Input = [ListItem]
    typealias Failure = Never

    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    func receive(_ input: [ListItem]) -> Subscribers.Demand {
        self.items = input
        return .none
    }

    func receive(completion: Subscribers.Completion<Never>) {
        print("Received completion", completion)
    }

    var items = [ListItem]() {
        didSet {
            tableView?.reloadData()
        }
    }

    weak var tableView: UITableView?
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = items[indexPath.row].done ? .checkmark : .none
        cell.textLabel?.text = items[indexPath.row].item
        return cell
    }
}
