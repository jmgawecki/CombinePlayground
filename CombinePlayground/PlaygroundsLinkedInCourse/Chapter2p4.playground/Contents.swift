import Foundation
import Combine
import UIKit

[4,5,6]
    .publisher
    .sink { value in
        print(value)
    }


let label = UILabel()
Just("Kuba")
    .map { "my name is \($0)" }
    .assign(to: \.text, on: label)

label.text





