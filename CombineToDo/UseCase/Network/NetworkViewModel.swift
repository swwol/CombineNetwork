import Combine

final class NetworkViewModel {

    let networkRepository: NetworkRepository

    init(networkRepository: NetworkRepository) {
        self.networkRepository = networkRepository
    }

    @Published var title: String? = nil
    @Published var body: String? = nil
    
    var cancellables = Set<AnyCancellable>()
    func didPressStart() {

        networkRepository
            .getPost()
            .sink(receiveCompletion: { print($0)},
                  receiveValue: { post in
                    self.title = post.title
                    self.body = post.body
                  })
            .store(in: &cancellables)
        }
    }

