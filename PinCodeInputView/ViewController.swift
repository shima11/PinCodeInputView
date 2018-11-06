//
//  ViewController.swift
//  PinCodeInputView
//
//  Created by Jinsei Shima on 2018/11/05.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let pinCodeInputView = PinCodeInputView(digit: 6)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pinCodeInputView)
        
        pinCodeInputView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 40, height: 80)
        pinCodeInputView.center = view.center
        pinCodeInputView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tap() {
        pinCodeInputView.resignFirstResponder()
    }
    
}

extension ViewController: PinCodeInputViewDelegate {
    
    func change(text: String) {
        print(text)
    }
}

protocol PinCodeInputViewDelegate {
    func change(text: String)
}

class PinCodeInputView: UIControl, UITextInputTraits {
    
    class ItemView: UIView {
        
        var text: String = "" {
            didSet {
                label.text = text
            }
        }
        
        var isHiddenCursor: Bool = true {
            didSet {
                cursor.isHidden = isHiddenCursor
            }
        }
        
        private let label: UILabel = .init()
        private let cursor: UIView = .init()
        
        init() {
            
            super.init(frame: .zero)
            
            backgroundColor = UIColor.black.withAlphaComponent(0.3)
            addSubview(label)
            addSubview(cursor)
            
            label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
            label.textColor = .white
            label.textAlignment = .center
            label.isUserInteractionEnabled = false
            
            cursor.backgroundColor = UIColor(red: 69/255, green: 108/255, blue: 1, alpha: 1)
            cursor.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
            
            cursor.isHidden = true
            
            UIView.animateKeyframes(
                withDuration: 1.6,
                delay: 0.8,
                options: [.repeat],
                animations: {
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                        self.cursor.alpha = 0
                    })
                    UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
                        self.cursor.alpha = 1
                    })
            },
                completion: nil
            )
            
            layer.cornerRadius = 8
            clipsToBounds = true
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            label.frame = bounds
            
            let width: CGFloat = 3
            let height: CGFloat = bounds.height * 0.6
            cursor.frame = CGRect(x: (bounds.width - width)/2, y: (bounds.height - height)/2, width: width, height: height)
        }
        
    }
    
    var text: String = "" {
        didSet {
            delegate?.change(text: text)
            showCursor()
        }
    }
    
//    var isEmpty: Bool {
//        return text.isEmpty
//    }
//
//    var isFilled: Bool {
//        return text.count == digit
//    }
    
    var delegate: PinCodeInputViewDelegate? = nil

    private let digit: Int
    
    private let items: [ItemView]
    private let stackView: UIStackView = .init()
    
    init(digit: Int) {
        
        self.digit = digit
        self.items = (0..<digit).map { _ in ItemView() }
        
        super.init(frame: .zero)
        
        addSubview(stackView)
        
        items.enumerated().forEach { (index, item) in
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
            item.addGestureRecognizer(tapGesture)
            stackView.addArrangedSubview(item)
        }
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
    }
    
    @objc func didTap() {
        // TODO:途中で編集する機能がない
        showCursor()
        becomeFirstResponder()
    }
    
    private func showCursor() {
        let cursorPosition = text.count
        items.enumerated().forEach { (index, item) in
            if (0..<text.count).contains(index) {
                let _index = text.index(text.startIndex, offsetBy: index)
                item.text = String(text[_index])
            } else {
                item.text = ""
            }
            item.isHiddenCursor = (index == cursorPosition) ? false : true
        }
    }

    // TODO: キーボードを閉じたときにカーソルを消す機能
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    open var autocapitalizationType = UITextAutocapitalizationType.none
    open var autocorrectionType = UITextAutocorrectionType.no
    open var spellCheckingType = UITextSpellCheckingType.no
    open var keyboardType = UIKeyboardType.numberPad
    open var keyboardAppearance = UIKeyboardAppearance.default
    open var returnKeyType = UIReturnKeyType.done
    open var enablesReturnKeyAutomatically = true
    
    open override var canBecomeFirstResponder: Bool {
        return true
    }
    
//    open override var intrinsicContentSize: CGSize {
//        return self.bounds.size
//    }
    
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

