import Networking
import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String

    static func get() -> Resource<Networking.Empty, Post> {
        return Resource(endpoint: "/posts/1", method: .get, decoder: JSONDecoder())
    }
}
