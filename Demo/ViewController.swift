//
//  ViewController.swift
//  PinCodeInputView
//
//  Created by Jinsei Shima on 2018/11/05.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import UIKit
import PinCodeInputView


//class CustomItem: UIView, ItemType {
//
//    var text: Character? = nil
//
//    var isHiddenCursor: Bool = false
//
//    var label: UILabel = .init()
//
//    var cursor: UIView = .init()
//
//    func set(appearance: Appearance) {
//
//        label.font = appearance.font
//        label.textColor = appearance.textColor
//        cursor.backgroundColor = appearance.cursorColor
//        backgroundColor = appearance.backgroundColor
//        layer.cornerRadius = appearance.cornerRadius
//        layoutIfNeeded()
//    }
//
//    init() {
//
//        super.init(frame: .zero)
//
//        addSubview(label)
//        addSubview(cursor)
//
//        clipsToBounds = true
//
//        label.textAlignment = .center
//        label.isUserInteractionEnabled = false
//
//        cursor.isHidden = true
//
//        UIView.animateKeyframes(
//            withDuration: 1.6,
//            delay: 0.8,
//            options: [.repeat],
//            animations: {
//                UIView.addKeyframe(
//                    withRelativeStartTime: 0,
//                    relativeDuration: 0.2,
//                    animations: {
//                        self.cursor.alpha = 0
//                })
//                UIView.addKeyframe(
//                    withRelativeStartTime: 0.8,
//                    relativeDuration: 0.2,
//                    animations: {
//                        self.cursor.alpha = 1
//                })
//        },
//            completion: nil
//        )
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        label.frame = bounds
//
//        let width: CGFloat = 2
//        let height: CGFloat = bounds.height * 0.6
//
//        cursor.frame = CGRect(
//            x: (bounds.width - width) / 2,
//            y: (bounds.height - height) / 2,
//            width: width,
//            height: height
//        )
//
//    }
//}

class ViewController: UIViewController {
    
    // default item
    let pinCodeInputView: PinCodeInputView<ItemView> = .init(
        digit: 6,
        itemFactory: {
        return ItemView()
    })
    
    // custom item
//    let pinCodeInputView: PinCodeInputView = .init(_items: (0..<6).map { _ in CustomItem() } )

    let enterButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(didBecameActive),
                name: UIApplication.didBecomeActiveNotification,
                object: nil
        )
        
        let titleLabel = UILabel()
        titleLabel.text = "Enter a PIN Code"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = .darkGray
        view.addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 56, height: 60)
        titleLabel.center = CGPoint(x: view.center.x, y: view.center.y - 94)
        
        pinCodeInputView.set(changeTextHandler: { [weak self] text in
            if self?.pinCodeInputView.isFilled == true {
                self?.enterButton.backgroundColor = .darkGray
            } else {
                self?.enterButton.backgroundColor = .lightGray
            }
        })
        view.addSubview(pinCodeInputView)
        pinCodeInputView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 56, height: 80)
        pinCodeInputView.center = view.center
//        pinCodeInputView.set(
//            appearance: .init(
//                font: .systemFont(ofSize: 28, weight: .bold),
//                textColor: .white,
//                backgroundColor: UIColor.black.withAlphaComponent(0.3),
//                cursorColor: UIColor(red: 69/255, green: 108/255, blue: 1, alpha: 1),
//                cornerRadius: 8,
//                spacing: 8
//            )
//        )
        
        enterButton.frame = CGRect(x: 0, y: 0, width: 240, height: 60)
        enterButton.center = CGPoint(x: view.center.x, y: view.center.y + 220)
        enterButton.setTitle("Enter", for: .normal)
        enterButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        enterButton.layer.cornerRadius = 30
        enterButton.clipsToBounds = true
        enterButton.backgroundColor = .lightGray
        enterButton.setTitleColor(.white, for: .normal)
        view.addSubview(enterButton)

    }
    
    @objc func didBecameActive() {
        
        print("did became active")
        print("string:", UIPasteboard.general.strings ?? "")
        print("url:", UIPasteboard.general.urls ?? "")
        print("color:", UIPasteboard.general.colors ?? "")
        print("image:", UIPasteboard.general.images ?? "")
        
        if let string = UIPasteboard.general.string {
            pinCodeInputView.set(text: string)
        }
    }
    
    @objc func tap() {
        pinCodeInputView.resignFirstResponder()
    }
    
}
