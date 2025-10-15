import SwiftUI


#if os(iOS)
import UIKit
extension UITextField {
    func addDoneButtonOnKeyboard() {
        let toolbar: UIToolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem
        if #available(iOS 26.0, *) {
            doneButton = UIBarButtonItem(title: "Done", style: .prominent, target: self, action: #selector(self.doneButtonAction))
        } else {
            doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        }

        toolbar.setItems([flexSpace, doneButton], animated: false)
        self.inputAccessoryView = toolbar
    }

    @objc func doneButtonAction() {
        self.resignFirstResponder() // Dismiss the keyboard
    }
}

struct DecimalTextFieldUIKit: UIViewRepresentable {
    @Binding var value: Double
    var placeholder: String

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.keyboardType = .decimalPad
        textField.delegate = context.coordinator
        textField.addDoneButtonOnKeyboard()
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        let formattedValue = String(format: "%.2f", value)
        if uiView.text != formattedValue {
            uiView.text = formattedValue
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var value: Double

        init(value: Binding<Double>) {
            _value = value
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let formatter = NumberFormatter()
            let decimalSeparator = formatter.decimalSeparator ?? "."
            let allowedCharacters = CharacterSet(charactersIn: "0123456789\(decimalSeparator)")
            return allowedCharacters.isSuperset(of: CharacterSet(charactersIn: string))
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            if let text = textField.text, let number = Double(text) {
                value = number
            }
        }
    }
}
#endif

#if os(macOS)
import AppKit

struct DecimalTextFieldAppKit: NSViewRepresentable {
    @Binding var value: Double
    var placeholder: String

    func makeNSView(context: Context) -> NSTextField {
        let textField = NSTextField()
        textField.placeholderString = placeholder
        textField.delegate = context.coordinator
        return textField
    }

    func updateNSView(_ nsView: NSTextField, context: Context) {
        let formattedValue = String(format: "%.2f", value)
        if nsView.stringValue != formattedValue {
            nsView.stringValue = formattedValue
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }

    class Coordinator: NSObject, NSTextFieldDelegate {
        @Binding var value: Double

        init(value: Binding<Double>) {
            _value = value
        }

        func controlTextDidChange(_ notification: Notification) {
            if let textField = notification.object as? NSTextField, let number = Double(textField.stringValue) {
                value = number
            }
        }
    }
}
#endif

struct DecimalTextField: View {
    @Binding var value: Double
    var placeholder: String

    var body: some View {
        #if os(iOS)
        DecimalTextFieldUIKit(value: $value, placeholder: placeholder)
        #else
        DecimalTextFieldAppKit(value: $value, placeholder: placeholder)
        #endif
    }
}

