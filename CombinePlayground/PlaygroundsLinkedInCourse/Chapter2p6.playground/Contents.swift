import Foundation
import Combine
import SwiftUI


enum FutureError: String, Error {
    case notMultiple2 = "The number is not a multiple of 2"
    case notMultipleOf2and4 = "The number is not a multiple of 2 and 4"
}


let future = Future<String, FutureError> { promise in
    let second = Calendar.current.component(.second, from: Date())
    
    if second.isMultiple(of: 2){
        if second.isMultiple(of: 4) {
            promise(.success("the number is a multiple of 2 and 4!"))
        } else {
            promise(.failure(.notMultipleOf2and4))
        }
    } else {
        promise(.failure(.notMultiple2))
    }
}
// if .catch() catches error from Future Publisher, it replaces the result of that Publisher with another Publisher
// .catch() cause that the publisher will never fail, as in a failure case it will return newly created Publisher
.catch({ customError in
    Just(customError.rawValue)
})
.delay(for: .init(1), scheduler: RunLoop.main)
//.eraseToAnyPublisher()


let subscriber = future
        .sink { print($0) }

