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
    
    let pinCodeInputView: PinCodeInputView = .init(digit: 6)
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
        pinCodeInputView.set(
            appearance: .init(
                font: .systemFont(ofSize: 28, weight: .bold),
                textColor: .white,
                backgroundColor: UIColor.black.withAlphaComponent(0.3),
                cursorColor: UIColor(red: 69/255, green: 108/255, blue: 1, alpha: 1),
                cornerRadius: 8,
                spacing: 8
            )
        )
        
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
