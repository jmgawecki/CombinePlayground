import Combine

var numbers = [1,3,5,7,9]
    .publisher


var numbersTwo = [2,4,6,8,10]
    .publisher
//    .merge(with: numbers)
//    .zip(numbers)
//    .combineLatest(numbers)
    .collect()
    .sink(receiveValue: { print($0) })



