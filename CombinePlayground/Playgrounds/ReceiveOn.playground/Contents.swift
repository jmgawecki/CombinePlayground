import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let intSubject = PassthroughSubject<Int, Never>()

let subscription = intSubject
   .map { $0 } // lets say you do some expensive map here
   // It would be much better to do so on a back thread
   .receive(on: RunLoop.main)
   .sink { value in
      print("Received value: \(value)")
      print(Thread.current)
   }
intSubject.send(1)
DispatchQueue.global().async { intSubject.send(2) }
