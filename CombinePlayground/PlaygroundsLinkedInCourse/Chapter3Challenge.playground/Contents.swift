import Foundation
import Combine


let url = URL.init(string: "https://jsonplaceholder.typicode.com/posts")!

struct Task: Codable {
    let id: Int
    let title: String
    let userId: Int
    let body: String
}

enum CustomError: Error {
    case responseError(error: URLError.Code)
}

let publisher = URLSession.shared.dataTaskPublisher(for: url)
    .tryMap { data, response in
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CustomError.responseError(error: URLError.badServerResponse)
        }
        return data
    }
    .decode(type: [Task].self, decoder: JSONDecoder())
    .map { tasks in
        tasks.first
    }
    .replaceNil(with: Task(id: 123, title: "123", userId: 123, body: "123"))
    .map { $0.title }

let subscriber = publisher
    .sink { completion in
        switch completion {
        case .finished:
            print("success")
        case .failure(let error):
            print(error.localizedDescription)
        }
    } receiveValue: { firstPostTitle in
        print(firstPostTitle)
    }

