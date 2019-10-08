import UIKit
import Combine

protocol ListDataSourceDelegate: AnyObject {
    func sync(items: [ListItem], on: ListDataSource)
}

final class ListDataSource: NSObject, UITableViewDataSource, Subscriber {

    typealias Input = [ListItem]
    typealias Failure = Never

    var items = [ListItem]()
    weak var tableView: UITableView?
    weak var delegate: ListDataSourceDelegate?

    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    func receive(_ input: [ListItem]) -> Subscribers.Demand {
        guard self.items != input else { return .none }
        self.items = input
        tableView?.reloadData()
        return .none
    }

    func receive(completion: Subscribers.Completion<Never>) {
        print("Received completion", completion)
    }


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

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            delegate?.sync(items: items, on: self)
            self.tableView?.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
