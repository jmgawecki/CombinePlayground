import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


let food: Publishers.Sequence<[String], Never> = ["Bier", "Bröt", "Salat", "Käse"].publisher

let timerPublisher = Timer.publish(every: 1, on: .main, in: .common)
   .autoconnect()

let calendar = Calendar.current
let endDate = calendar.date(byAdding: .second, value: 3, to: Date())!

enum MyError: String, Error {
   case error = "Fatal error, sorry about that mate."
}

func throwAtEndDate(foodItem: String, date: Date) throws -> String {
   if date < endDate { // this condition will fail after 2 seconds because we made it this way, so it will return an error
      return "\(foodItem) at \(date)"
   } else {
      throw MyError.error
   }
}

let subscription = food.zip(timerPublisher)
   .tryMap { (foodItem, timestamp) -> String in
      try throwAtEndDate(foodItem: foodItem, date: timestamp) // by creating a throwing function, we considering an error
   }
   .sink { completion in
      switch completion {
      case .finished:
         print("completion finished")
      case .failure(let error):
         print(error.localizedDescription)
      }
   } receiveValue: { foodItem in
      print("The food is: \(foodItem)")
   }



