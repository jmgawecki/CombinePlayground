import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
var subscriptions = Set<AnyCancellable>()

private func fetchFollowers(with username: String, for page: Int) {
   let baseUrlString = "https://api.github.com/users/"
   let endPointString = baseUrlString + "\(username)/followers?per_page=100&page=\(page)"
   guard let url = URL(string: endPointString) else {    // 1.
      print("creating url failed")
      return
   }
   
   let decoder = JSONDecoder()                           // 2.
   decoder.keyDecodingStrategy = .convertFromSnakeCase   // 3.
   
   URLSession.shared.dataTaskPublisher(for: url)
      .sink { completion in
         if case .failure(let error) = completion {
            print(error.localizedDescription)
         }
      } receiveValue: { (data, response) in
         print("received data: \(data), response \(response)")
      }
      .store(in: &subscriptions)
}

private func fetchFollowers2(with username: String, for page: Int) {
   let baseUrlString    = "https://api.github.com/users/"
   let endPointString   = baseUrlString + "\(username)/followers?per_page=100&page=\(page)"
   guard let url = URL(string: endPointString) else {
      print("creating url failed")
      return
   }
   
   let decoder = JSONDecoder()
   decoder.keyDecodingStrategy = .convertFromSnakeCase
   
   URLSession.shared.dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: [Follower].self, decoder: decoder)
      .sink { completion in
         if case .failure(let error) = completion {
            print(error.localizedDescription)
         }
      } receiveValue: { followers in
         print("received data: \(followers)")
      }
      .store(in: &subscriptions)
}


func getFollowers(username: String, page: Int, completed: @escaping(Result<[Follower],Error>) -> Void) {
   let baserURL = "https://api.github.com/users/"
   let endpoint = baserURL + "\(username)/followers?per_page=100&page=\(page)"
   guard let url = URL(string: endpoint) else {
      print("error")
      return
      
   }
   
   let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let _ = error { completed(.failure(error!))}
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { completed(.failure(error!)); return}
      
      guard let data = data else { completed(.failure(error!)); return}
      
      do {
         let decoder = JSONDecoder()
         decoder.keyDecodingStrategy = .convertFromSnakeCase
         let followers = try decoder.decode([Follower].self, from: data)
         completed(.success(followers))
      } catch { completed(.failure(error)) }
   }
   task.resume()
}




fetchFollowers2(with: "jmgawecki", for: 1)
getFollowers(username: "jmgawecki", page: 1) { result in
   switch result {
   
   case .success(let followers):
      print(followers)
   case .failure(let error):
      print(error.localizedDescription)
   }
}


























protocol FollowerProtocol {
   var login: String { get set }
   var avatarUrl: String { get set }
}

struct Follower: FollowerProtocol, Codable, Hashable, Identifiable {
   var id = UUID()
   var login:      String
   var avatarUrl:  String
}
