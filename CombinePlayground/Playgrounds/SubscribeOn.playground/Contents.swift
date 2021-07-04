import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var cancellables = Set<AnyCancellable>()
let intSubject = PassthroughSubject<Int, Never>()

intSubject
   .sink { value in
      print(value)
      print(Thread.current)
   }
   .store(in: &cancellables)

intSubject.send(1)
intSubject.send(2)
intSubject.send(3)
