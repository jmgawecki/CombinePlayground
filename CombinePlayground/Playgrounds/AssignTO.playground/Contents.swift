import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class myModel: ObservableObject {
   
   @Published var lastUpdated: Date = Date()
   
   init() {
      Timer.publish(every: 1.0, on: RunLoop.main, in: .common)
         .autoconnect()
   }
}
