import Foundation

struct ListItem: Codable, Equatable {
    let item: String
    let done: Bool

    func toggled() -> ListItem {
        return ListItem(item: self.item, done: !self.done)
    }
}
