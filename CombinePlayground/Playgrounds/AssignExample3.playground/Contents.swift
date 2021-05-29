import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct User {
   let name:   String
   let age:    Int
   let id:     Int
}

class ViewModel: ObservableObject {
   
   var user = CurrentValueSubject<User, Never>(User(name: "Jakub", age: 24, id: 1))
   var userID: Int = 1 {
      didSet {
         print("user ID changed: \(userID)")
      }
   }
   
   var subscriptions = Set<AnyCancellable>()
   
   init() {
      user
         .dropFirst()
         .map(\.id)
         .sink { [weak self] value in
            guard let self = self else { return }
            self.userID = value
         }
         .store(in: &subscriptions)
   }
   
   deinit { print("deinitialized") }
}


var viewModel: ViewModel? = ViewModel()
viewModel?.user.send(User(name: "Kiarek", age: 6, id: 2))
viewModel = nil
