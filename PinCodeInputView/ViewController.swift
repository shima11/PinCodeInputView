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
    
    class ItemView: UIView {
        
        var text: String = "" {
            didSet {
                label.text = text
            }
        }
        
        var showCursor: Bool = false {
            didSet {
                cursor.isHidden = !showCursor
            }
        }
        
        private let label: UILabel = .init()
        // 正式名称 caret
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
            print("text:", text)
            let cursorPosition = text.count
            // テキストの更新
            items.enumerated().forEach { (index, item) in
                if (0..<text.count).contains(index) {
                    let _index = text.index(text.startIndex, offsetBy: index)
                    item.text = String(text[_index])
                } else {
                    item.text = ""
                }
                // cursorの表示
                item.showCursor = (index == cursorPosition) ? true : false
            }
//            setNeedsDisplay()
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
        items.first?.showCursor = true
        becomeFirstResponder()
    }
    
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

