import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var subscriber: AnyCancellable? = Timer.publish(every: 0.1, tolerance: nil, on: RunLoop.main, in: .common, options: nil)
   .autoconnect()
   .throttle(for: .seconds(2), scheduler: RunLoop.main, latest: false)
   // Its probably better to keep the .throttle upfront
   .scan(0, { count, _ in
      return count + 1
   })
   .filter { $0.isMultiple(of: 2) }
   .sink { completion in
      print("datastream completion: \(completion)")
   } receiveValue: { counter in
      print("received value: \(counter)")
   }


DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
   subscriber = nil
}
