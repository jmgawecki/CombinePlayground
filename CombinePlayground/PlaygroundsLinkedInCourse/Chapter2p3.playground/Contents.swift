import Foundation
import Combine
import UIKit



[1,5,9]
    .publisher
    .map { $0 * $0 }
    .sink { value in
        print(value)
    }


let url = URL.init(string: "https://jsonplaceholder.typicode.com/posts")!

struct Task: Codable {
    let id: Int
    let title: String
    let userId: Int
    let body: String
}

var cancellables: Set<AnyCancellable> = []
URLSession.shared.dataTaskPublisher(for: url)
    .map { $0.data }
    .decode(type: [Task].self, decoder: JSONDecoder())
    .sink { _ in
    } receiveValue: { tasks in
        print(tasks[0].title)
    }
    .store(in: &cancellables)


let publisher = URLSession.shared.dataTaskPublisher(for: url)
    .map { $0.data }
    .decode(type: [Task].self, decoder: JSONDecoder())

let subscriber = publisher
    .sink { _ in
    } receiveValue: { tasks in
        print(tasks[0].body)
    }
