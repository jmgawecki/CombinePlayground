import Combine
import UIKit





let textField = UITextField()

let booleanPublisher = [true, true, false, true, false, true, false]
    .publisher
    .dropFirst(2)

let isEnabledSubscriber = booleanPublisher
    .assign(to: \.isEnabled, on: textField)


let textFieldSubscribtion = textField.publisher(for: \.isEnabled)
    .sink { print("Value has changed to:\($0)") }

let valueSubscription = booleanPublisher
    .sink { print($0) }
    
