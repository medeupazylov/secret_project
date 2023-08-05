//
//  UsernameVC + TextFieldDelegate.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 05.08.2023.
//

import UIKit


extension UsernameViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) as? UITextField {
                nextTextField.becomeFirstResponder()
        } else {
               textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == K.Colors.labelTertiary && textView.text == placeholder {
//            textView.text = ""
//            textView.textColor = K.Colors.labelPrimary
//        }
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        textView.text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
//        if textView.text.isEmpty {
//            textView.text = placeholder
//            textView.textColor = K.Colors.labelTertiary
//            text = textView.text
//        }
        

}
