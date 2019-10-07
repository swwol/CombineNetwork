import UIKit

protocol Coordinator: class {}

enum PresentationStyle {
    case modal(navControllerType: NavControllerType, animated: Bool)
    case show(animated: Bool)
    case cleanShow(animated: Bool)
}

extension PresentationStyle {
    enum NavControllerType {
        case none
        case navBarHidden
        case navBarVisible
    }
}

extension Coordinator {
    func present(_ viewController: UIViewController,
                 style: PresentationStyle,
                 on context: UIViewController) {
        let controller: UIViewController

        switch style {
        case let .modal( navControllerType, _):
            switch navControllerType {
            case .navBarHidden, .navBarVisible:
                let navBarHidden = navControllerType == .navBarHidden
                let navigationController = self.navigationController(navBarHidden: navBarHidden)
                navigationController.viewControllers = [viewController]
                controller = navigationController
            case .none:
                controller = viewController
            }
        case .show, .cleanShow:
            controller = viewController
        }

        switch style {
        case let .modal(_, isAnimated):
            context.present(controller, animated: isAnimated)
        case let .show(isAnimated):
            if let navigationController = context as? UINavigationController {
                if navigationController.viewControllers.isEmpty {
                    navigationController.setViewControllers([controller],
                                                            animated: isAnimated)
                } else {
                    navigationController.pushViewController(controller,
                                                            animated: isAnimated)
                }
            } else {
                context.show(controller, sender: self)
            }
        case .cleanShow(let isAnimated):
            if let navigationController = context as? UINavigationController {
                navigationController.setViewControllers([controller],
                                                        animated: isAnimated)
            } else {
                context.show(controller, sender: self)
            }
        }
    }

    private func navigationController(navBarHidden: Bool) -> UINavigationController {
        let navigationController: UINavigationController

        // If the navigation bar is hidden, there is no need to use the custom subclass.
        if navBarHidden {
            navigationController = UINavigationController(navigationBarClass: BlankNavigationBar.self,
                                                          toolbarClass: nil)
        } else {
            navigationController = BlankBackNavigationController(navigationBarClass: BlankNavigationBar.self,
                                                                 toolbarClass: nil)
        }

        navigationController.isNavigationBarHidden = navBarHidden
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.view.backgroundColor = .white

        return navigationController
    }
}

