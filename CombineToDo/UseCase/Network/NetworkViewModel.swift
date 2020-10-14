import Combine

final class NetworkViewModel: ObservableObject {

    let networkRepository: NetworkRepository

    init(networkRepository: NetworkRepository) {
        self.networkRepository = networkRepository
    }

    @Published private(set) var body: String?
    @Published private(set) var title: String?

    func didPressStart() {

        let post = networkRepository.getPost()

        post
            .map { $0.body }
            .replaceError(with: "")
            .assign(to: &$body)

        post
            .map { $0.title }
            .replaceError(with: "")
            .assign(to: &$title)
    }
}

