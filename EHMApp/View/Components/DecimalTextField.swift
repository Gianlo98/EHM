//
//  DecimalTextField.swift
//  EHM
//
//  Created by Gianlo Personal on 01.10.2024.
//
import SwiftUI

struct DecimalTextField: View {
    @Binding var value: Double
    var placeholder: String

    #if os(iOS)
    var body: some View {
        DecimalTextFieldUIKit(value: $value, placeholder: placeholder)
    }
    #else
    var body: some View {
        DecimalTextFieldAppKit(value: $value, placeholder: placeholder)
    }
    #endif
}

#if os(iOS)
import UIKit

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
        uiView.text = String(format: "%.2f", value)
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
            // Allow numbers, one decimal separator, and locale-aware formatting
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            let decimalSeparator = formatter.decimalSeparator ?? "."
            let allowedCharacters = CharacterSet(charactersIn: "0123456789\(decimalSeparator)")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            if let text = textField.text,
               let number = NumberFormatter().number(from: text)?.doubleValue {
                value = number
            }
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
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
        textField.isBezeled = true
        textField.bezelStyle = .roundedBezel
        return textField
    }

    func updateNSView(_ nsView: NSTextField, context: Context) {
        nsView.stringValue = String(format: "%.2f", value)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }

    class Coordinator: NSObject, NSTextFieldDelegate {
        @Binding var value: Double

        init(value: Binding<Double>) {
            _value = value
        }

        func controlTextDidEndEditing(_ obj: Notification) {
            if let textField = obj.object as? NSTextField,
               let number = NumberFormatter().number(from: textField.stringValue)?.doubleValue {
                value = number
            }
        }
    }
}
#endif
