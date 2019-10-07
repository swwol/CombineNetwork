import UIKit
import Combine

extension NotificationCenter {

    func didChange(textField: UITextField, completion: @escaping (String?) -> Void) -> AnyCancellable {

        return NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: textField)
            .map { notification in
                return (notification.object as! UITextField).text
        }.replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { string in
                completion(string)
            }
        )
    }
}
