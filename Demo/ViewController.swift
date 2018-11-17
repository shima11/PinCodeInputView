//
//  ViewController.swift
//  PinCodeInputView
//
//  Created by Jinsei Shima on 2018/11/05.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import UIKit
import PinCodeInputView

class ViewController: UIViewController {

    // default item view
    let pinCodeInputView: PinCodeInputView<ItemView> = .init(
        digit: 6,
        itemSpacing: 8,
        itemFactory: {
            return ItemView()
    })

    // customize item view (underline)
//    let pinCodeInputView: PinCodeInputView<UnderlineItemView> = .init(
//        digit: 6,
//        itemSpacing: 8,
//        itemFactory: {
//        return UnderlineItemView()
//    })

    // customize item view (circle)
//    let pinCodeInputView: PinCodeInputView<CircleItemView> = .init(
//        digit: 6,
//        itemSpacing: 8,
//        itemFactory: {
//            return CircleItemView()
//    })

    // customize item view (password)
//    let pinCodeInputView: PinCodeInputView<PasswordItemView> = .init(
//        digit: 4,
//        itemSpacing: 24,
//        itemFactory: {
//            return PasswordItemView()
//    })

    private let titleLabel = UILabel()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(titleLabel)
        view.addSubview(pinCodeInputView)

        view.backgroundColor = .black

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
        
        titleLabel.text = "Enter a PIN Code"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = UIColor.lightText
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 56, height: 60)
        titleLabel.center = CGPoint(x: view.center.x, y: view.center.y - 94)

        pinCodeInputView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 56, height: 80)
        pinCodeInputView.center = view.center
        pinCodeInputView.set(changeTextHandler: { text in
            print(text)
        })
        pinCodeInputView.set(
            appearance: .init(
                itemSize: CGSize(width: 44, height: 68),
                font: .systemFont(ofSize: 28, weight: .bold),
                textColor: .white,
                backgroundColor: UIColor.white.withAlphaComponent(0.3),
                cursorColor: UIColor(red: 69/255, green: 108/255, blue: 1, alpha: 1),
                cornerRadius: 8
            )
        )
        
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(didBecameActive),
                name: UIApplication.didBecomeActiveNotification,
                object: nil
        )
        
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
