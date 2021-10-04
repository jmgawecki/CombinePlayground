import Foundation
import Combine

Just("Hello World")
    .sink { value in
        print(value)
    }


let notification = Notification(name: .NSSystemClockDidChange, object: nil, userInfo: nil)
let notificationClockPublisher = NotificationCenter.default.publisher(for: .NSSystemClockDidChange)
    .sink { value in
        print(value)
    }
NotificationCenter.default.post(notification)



