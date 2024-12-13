//
//  DecimalTextField.swift
//  EHM
//
//  Created by Gianlo Personal on 01.10.2024.
//

import SwiftUI
import UIKit

struct DecimalTextField: UIViewRepresentable {
    @Binding var value: Double
    var placeholder: String

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var value: Double

        init(value: Binding<Double>) {
            _value = value
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Allow only numbers and one decimal separator
            let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            if let text = textField.text, let number = Double(text) {
                value = number
            }
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder() // Dismiss the keyboard
            return true
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(value: $value)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.keyboardType = .decimalPad
        textField.delegate = context.coordinator
        textField.addDoneButtonOnKeyboard() // Add "Done" button
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = String(format: "%.2f", value)
    }
}

extension UITextField {
    func addDoneButtonOnKeyboard() {
        let toolbar: UIToolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        toolbar.setItems([flexSpace, doneButton], animated: false)
        self.inputAccessoryView = toolbar
    }

    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
