//
//  ViewController.swift
//  PinCodeInputView
//
//  Created by Jinsei Shima on 2018/11/05.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputView = PinCodeInputView(digit: 6)
        view.addSubview(inputView)
        
        inputView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 40, height: 80)
        inputView.center = view.center
        
    }
}

protocol PinCodeInputViewDelegate {
    // TODO: hogehoge
    func changeText()
}

class PinCodeInputView: UIControl, UITextInputTraits {
    
    var text: String = "" {
        didSet {
            print("text:", text)
            items.enumerated().forEach { (index, item) in
                if (0..<text.count).contains(index) {
                    let _index = text.index(text.startIndex, offsetBy: index)
                    item.label.text = String(text[_index])
                } else {
                    item.label.text = ""
                }
            }
        }
    }
    
//    var isEmpty: Bool {
//        return text.isEmpty
//    }
//
//    var isFilled: Bool {
//        return text.count == digit
//    }
    
    private var delegate: PinCodeInputViewDelegate? = nil

    private let digit: Int
    
    private let items: [ItemView]
    private let stackView: UIStackView = .init()
    
    class ItemView: UIView {
        
        let label: UILabel = .init()
        
        init() {
            
            super.init(frame: .zero)
            
            backgroundColor = UIColor.black.withAlphaComponent(0.3)
            addSubview(label)
            
            label.isUserInteractionEnabled = false
            
            layer.cornerRadius = 8
            clipsToBounds = true
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            label.frame = bounds
        }
        
    }
    
    init(digit: Int) {
        
        self.digit = digit
        self.items = (0..<digit).map { _ in ItemView() }
        
        super.init(frame: .zero)
        
        addSubview(stackView)
        
        items.forEach {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
            $0.addGestureRecognizer(tapGesture)
            stackView.addArrangedSubview($0)
        }
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
    }
    
    @objc func didTap() {
        becomeFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    
    // MARK: UITextInputTraits protocol properties
    
    open var autocapitalizationType = UITextAutocapitalizationType.none
    open var autocorrectionType = UITextAutocorrectionType.no
    open var spellCheckingType = UITextSpellCheckingType.no
    open var keyboardType = UIKeyboardType.numberPad
    open var keyboardAppearance = UIKeyboardAppearance.default
    open var returnKeyType = UIReturnKeyType.done
    open var enablesReturnKeyAutomatically = true
    
    // MARK: UIResponder
    
    open override var canBecomeFirstResponder: Bool {
        return true
    }
    
    private var accessoryView: UIView?
    
    override open var inputAccessoryView: UIView? {
        get {
            return accessoryView
        }
        set(value) {
            accessoryView = value
        }
    }
    
    //MARK: UIView
    
    open override var intrinsicContentSize: CGSize {
        return self.bounds.size
    }
    
}

extension PinCodeInputView : UIKeyInput {
    
    open var hasText: Bool {
        return !(text.isEmpty)
    }
    
    open func insertText(_ textToInsert: String) {
        if isEnabled && text.count + textToInsert.count <= digit {
            text.append(textToInsert)
            sendActions(for: .editingChanged)
        }
    }
    
    open func deleteBackward() {
        if isEnabled && !text.isEmpty {
            text.removeLast()
            sendActions(for: .editingChanged)
        }        
    }
    
}

