import UIKit
import Combine
import PlaygroundSupport

//PlaygroundPage.current.needsIndefiniteExecution = true

class TextFieldViewController: UIViewController {
   
   var label:     UILabel = UILabel()
   var textField: UITextField!
   
   var textMessage   = CurrentValueSubject<String, Never>("Hello World")

   var subsriptions  = Set<AnyCancellable>()
   
   override func loadView() {
      let view                   = UIView()
      view.backgroundColor       = .systemRed
   
      textField                  = UITextField()
      textField.borderStyle      = .roundedRect
      textField.text             = textMessage.value

      label                      = UILabel()
      label.backgroundColor      = .systemGreen
      
      
      textMessage
         .dropFirst()
         .compactMap { input in
            return "You typed: \(input)"
         } // to remove nil
         .assign(to: \.text, on: label)
         .store(in: &subsriptions)
      
      textField.translatesAutoresizingMaskIntoConstraints = false
      label.translatesAutoresizingMaskIntoConstraints = false
      
      view.addSubview(textField)
      view.addSubview(label)
      
      self.view = view
      
      let margins = view.layoutMarginsGuide
      NSLayoutConstraint.activate([
         textField.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
         textField.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
         textField.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
         textField.heightAnchor.constraint(equalToConstant: 50),
         
         label.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 0),
         label.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 0),
         label.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 0),
         label.heightAnchor.constraint(equalToConstant: 50),
      ])
      
      textField.addTarget(self, action: #selector(updateText), for: .editingChanged)
   }
   
   @objc func updateText() {
      self.textMessage.value = textField.text ?? ""
   }
}
//
//extension TextFieldViewController: UITextFieldDelegate {
//
//}

let controller = TextFieldViewController()

PlaygroundPage.current.liveView = controller
