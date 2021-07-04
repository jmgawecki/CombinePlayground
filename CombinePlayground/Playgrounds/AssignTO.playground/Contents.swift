import SwiftUI
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class myModel: ObservableObject {

   // Assign(to:) manages lifecycle of the subscription which mean it no longer needs to be stored in Cancellables
   // Usecase is different than assign(to: on:)
   // It can be use only with the Publisher property e.g. @Published var someProperty = 5
   
   @Published var lastUpdated: String = ""
   
   var dateFormatter: DateFormatter {
      let dateFormatter          = DateFormatter()
      dateFormatter.dateFormat   = "HH:mm:ss"
      return dateFormatter
   }
   
   init() {
      Timer.publish(every: 1.0, on: RunLoop.main, in: .common)
         .autoconnect()
         .map { [unowned self] timestamp in
            return self.dateFormatter.string(from: timestamp)
         }
         .assign(to: &$lastUpdated)
      // This way there are no memory leaks like with .assign(to:\.lastUpdated, on: self)
   }
}


struct MyView: View {
   @StateObject var viewModel = myModel()
   
   
   
   var body: some View {
      Text("\(viewModel.lastUpdated)")
         .fixedSize()
         .padding(50)
   }
}

PlaygroundPage.current.setLiveView(MyView())
