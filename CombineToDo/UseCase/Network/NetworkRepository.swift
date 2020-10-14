import Networking
import Combine
import Foundation

class NetworkRepository {

    let webservice = Networking.Webservice(baseURL: URL(string: "https://jsonplaceholder.typicode.com")!)

    func getPost() -> Future<Post, Error> {
        return Future<Post, Error> { promise in
            self.webservice.load(Post.get(), completion: promise)
        }
    }
}

