import Combine
import Foundation






let cityPublisher = ["Manchester", "Warsaw", "London"].publisher

final class CitySubscriber: Subscriber {
    func receive(subscription: Subscription) {
        return subscription.request(.max(2))
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print(input)
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print(completion)
    }
    
    typealias Input = String
    typealias Failure = Never
}

let citySubscribtion = CitySubscriber()
cityPublisher.subscribe(citySubscribtion)
