import UIKit

protocol BlankNavigationBarTitleDelegate: AnyObject {
    func updateForLargeTitles(on: BlankNavigationBar)
    func updateForSmallTitles(on: BlankNavigationBar)
}

final class BlankNavigationBar: UINavigationBar {

    weak var titleDelegate: BlankNavigationBarTitleDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        shadowImage = UIImage()
        isTranslucent = false
        tintColor = UIColor.blue
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 11.0, *) {
            if frame.height >= 80 {
                titleDelegate?.updateForLargeTitles(on: self)
            } else {
                titleDelegate?.updateForSmallTitles(on: self)
            }
        }
    }
}

final class BlankBackNavigationController: UINavigationController {
    override var delegate: UINavigationControllerDelegate? {
        get {
            return self
        }
        set {
            fatalError("Should not be used \(String(describing: newValue))")
        }
    }
}

extension BlankBackNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ",
                                                                          style: .plain,
                                                                          target: nil,
                                                                          action: nil)
    }
}
