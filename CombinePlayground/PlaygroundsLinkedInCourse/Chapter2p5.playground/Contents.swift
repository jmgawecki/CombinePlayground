import Foundation
import Combine
import SwiftUI

// MARK: - PassthroughSubject
let passthroughSubject = PassthroughSubject<Int, Never>() // Subject

let subscription = passthroughSubject.sink { value in // Subscriber
    print(value)
}

passthroughSubject.send(49) // sending a value to the passthroughSubject - Works as a Publisher

Just(29) // A Publisher that publishes an Integer
    .subscribe(passthroughSubject) // Attaches the passthroughSubject to this Publisher


// MARK: - CurrentValueSubject
let currentSubject = CurrentValueSubject<String, Never>("I am a...")

let currentSubscription = currentSubject
    .sink { text in
        print(text)
    }
currentSubject.send("Kuba")
currentSubject.send("Kuba")
currentSubject.send("Kuba")

Just("Dolphin")
    .subscribe(currentSubject)
