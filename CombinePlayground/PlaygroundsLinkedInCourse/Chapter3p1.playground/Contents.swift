import Foundation
import Combine


let url = URL.init(string: "https://jsonplaceholder.typicode.com/posts")!

struct Task: Codable {
    let id: Int
    let title: String
    let userId: Int
    let body: String
}

let dataPublisher = URLSession.shared.dataTaskPublisher(for: url)
    .tryMap { data, response in // With the tryMap() we can throw a specific error that we want to if something went north
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return data
    }
    .decode(type: [Task].self, decoder: JSONDecoder())
    .sink { completion in
        switch completion {
        case .finished:
            print("Fetching succesful")
        case .failure(let error):
            print(error.localizedDescription)
        }
    } receiveValue: { tasks in
        print(tasks[0].body)
    }

