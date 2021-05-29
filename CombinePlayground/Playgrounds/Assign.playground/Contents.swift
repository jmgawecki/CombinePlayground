import Combine
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class IntegerValue {
   var integ: Int = 0 {
      didSet {
         print("Value was set to \(integ)")
      }
   }
}

let integerObject = IntegerValue()

let values = [1,2,3,4,5,6].publisher
   .map { $0 }
   // Assigning happens with the writableKeypath for reference so it needs to be an object
   .assign(to: \.integ, on: integerObject)

let values2 = [1,2,3,4,5,6].publisher
   .map { $0 }
   // Sink will to the same
   .sink { value in
      integerObject.integ = value
   }

   
