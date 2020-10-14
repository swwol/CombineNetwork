import Combine

final class NetworkViewModel: ObservableObject {

    let networkRepository: NetworkRepository

    init(networkRepository: NetworkRepository) {
        self.networkRepository = networkRepository
    }

    @Published private(set) var title: String?
    @Published private(set) var body: String? = nil

    var titleSubject = PassthroughSubject<String, Never>()

    func didPressStart() {

        networkRepository
            .getPost()
            .map { $0.body }
            .replaceError(with: "error")
            .assign(to: &$body)

        networkRepository
            .getPost()
            .map { $0.title }
            .replaceError(with: "error")
            .assign(to: &$title)
    }
}

