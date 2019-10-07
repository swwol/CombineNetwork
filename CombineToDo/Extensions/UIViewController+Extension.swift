import UIKit

extension UIViewController {
    static func fromStoryboard<T: UIViewController>() -> T {
        let bundle = Bundle(for: self)
        let name = String(describing: self).replacingOccurrences(of: "ViewController", with: "")
        let storyboard = UIStoryboard(name: name, bundle: bundle)

        guard let viewController = storyboard.instantiateInitialViewController() as? T else {
            let error = """
            Storyboard for \(self) can't be instantiated.
            Make sure to set an initial viewcontroller in the Storyboard and assign the correct custom class.
            """
            fatalError(error)
        }
        return viewController
    }

    static func fromStoryboard<T: UIViewController>(with identifyingClass: UIViewController.Type) -> T {
        let bundle = Bundle(for: self)
        let name = String(describing: self).replacingOccurrences(of: "ViewController", with: "")
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        let identifier = String(describing: identifyingClass)

        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            let error = """
            Storyboard for \(self) with identifier \(identifier) can't be instantiated.
            Make sure to set an initial viewcontroller in the Storyboard and assign the correct custom class.
            """
            fatalError(error)
        }
        return viewController
    }
}
