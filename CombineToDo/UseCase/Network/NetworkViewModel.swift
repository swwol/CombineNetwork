import Combine

protocol NetworkViewModelOutputsType  {
    var bodyPublisher: Published<String?>.Publisher { get }
    var titlePublisher: Published<String?>.Publisher { get }
}

protocol NetworkViewModelType {
    var outputs: NetworkViewModelOutputsType { get }
    var inputs: NetworkViewModelInputsType { get }
}

protocol NetworkViewModelInputsType {
    func didPressStart()
}


final class NetworkViewModel: ObservableObject, NetworkViewModelOutputsType, NetworkViewModelType, NetworkViewModelInputsType {

    var outputs: NetworkViewModelOutputsType { return self }
    var inputs: NetworkViewModelInputsType { return self }
    let networkRepository: NetworkRepository

    init(networkRepository: NetworkRepository) {
        self.networkRepository = networkRepository
    }

    @Published private(set) var body: String?
    @Published private(set) var title: String?

    var bodyPublisher: Published<String?>.Publisher { $body }
    var titlePublisher: Published<String?>.Publisher { $title }

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

