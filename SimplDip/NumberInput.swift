//
//  FirstResponderTextField.swift
//  SimpleDip
//
//  Created by Matt Stoffel on 6/8/21.
//

import SwiftUI

struct NumberInput: View {
    @Binding var text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.secondary)
            FirstResponderTextField(text: $text, isFirstResponder: true)
                .padding()
        }
    }
    
    struct FirstResponderTextField: UIViewRepresentable {
        
        @Binding var text: String
        var isFirstResponder = false
        
        class Coordinator: NSObject, UITextFieldDelegate {
            
            @Binding var text: String
            var didBecomeFirstResponder = false
            
            init(text: Binding<String>) {
                _text = text
            }
            
            func textFieldDidChangeSelection(_ textField: UITextField) {
                text = textField.text ?? ""
            }
        }
        
        func makeCoordinator() -> FirstResponderTextField.Coordinator {
            return Coordinator(text: $text)
        }
        
        func makeUIView(context: UIViewRepresentableContext<FirstResponderTextField>) -> UITextField {
            let textField = UITextField(frame: .zero)
            textField.font = UIFont.systemFont(ofSize: 60)
            textField.textColor = UIColor.white
            textField.keyboardType = UIKeyboardType.numberPad
            textField.tintColor = UIColor(.clear)
            textField.delegate = context.coordinator
            return textField
        }
        
        func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<FirstResponderTextField>) {
            uiView.text = text
            if !context.coordinator.didBecomeFirstResponder  {
                uiView.becomeFirstResponder()
                context.coordinator.didBecomeFirstResponder = true
            }
        }
        
        
    }

}


