import Foundation

protocol Persistable {
    func set(_ value: Any?, forKey key: String) throws
    func object(forKey key: String) -> Any?
    func removeAll()
}
extension UserDefaults {
    public func removeAll() {
        removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
}

extension UserDefaults: Persistable {}

