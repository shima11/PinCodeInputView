//
//  String+Validation.swift
//  PinCodeInputView
//
//  Created by Jinsei Shima on 2018/11/06.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import Foundation

enum Validator {
    
    private static let dataDetector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
    
    static func checkEmail(_ email: String) -> Bool {
        
        let firstMatch = Validator.dataDetector.firstMatch(
            in: email,
            options: [],
            range: NSRange(location: 0, length: (email as NSString).length)
        )
        return firstMatch?.url?.scheme == "mailto" && firstMatch?.url?.absoluteString == "mailto:\(email)"
    }
    
    static func isPinCode(text: String, digit: Int) -> Bool {
        if text.count == digit, isOnlyNumeric(text: text) {
            return true
        }
        return false
    }
    
    static func isOnly(text: String, _ characterSet: CharacterSet) -> Bool {
        return text.trimmingCharacters(in: characterSet).count <= 0
    }
    
    static func isOnlyNumeric(text: String) -> Bool {
        return isOnly(text: text, .decimalDigits)
    }

}
