import Foundation
import Combine


let url = URL.init(string: "https://jsonplacedholder.typicode.com/posts")!

enum CustomError: Error {
    case responseError(error: String)
}

struct Task: Codable {
    let id: Int
    let title: String
    let userId: Int
    let body: String
}

let dataPublisher = URLSession.shared.dataTaskPublisher(for: url)
    .map { $0.data }
    .retry(3)
    .decode(type: [Task].self, decoder: JSONDecoder())

let subscriber = dataPublisher
    .mapError { error -> Error in
        switch error {
        case URLError.cannotFindHost:
            return CustomError.responseError(error:"Something wrong with the host")
        case URLError.badServerResponse:
            return CustomError.responseError(error:"It seems that the website you are looking for does not exist")
        case URLError.cancelled:
            return CustomError.responseError(error:"Your connection has been cancelled, sorry about that.")
        default:
            return CustomError.responseError(error: "Defualt error")
        }
    }
    .sink { completion in
        switch completion {
        case .finished:
            print("success")
        case .failure(let error):
            print(String(describing: error))
        }
    } receiveValue: { tasks in
        print(tasks[0].body)
    }



enum IntegerError: String, Error {
    case miltupleOf2 = "We are sorry but the number is a multiple of 2, therefore cannot be used in the process"
}

let integerPublisher = [1,3,3,3,3,3,5,6,7,7].publisher
    .setFailureType(to: IntegerError.self)

let subscribtion = integerPublisher
    .tryMap { intValue in
        if intValue.isMultiple(of: 2) {
            throw IntegerError.miltupleOf2
        } else {
            return intValue
        }
    }
    .sink { completion in
        switch completion {
        case .finished:
            print("success")
        case .failure(let error):
            if let error = error as? IntegerError {
                print(error.rawValue)
            } else {
                print(error)
            }
        }
    } receiveValue: { value in
        print(value)
    }

