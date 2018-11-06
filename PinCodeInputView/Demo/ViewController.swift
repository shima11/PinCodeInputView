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

    override func viewDidLoad() {
        super.viewDidLoad()

        pinCodeInputView.set(changeTextHandler: { text in
            print(text)
        })
        view.addSubview(pinCodeInputView)
        pinCodeInputView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 40, height: 80)
        pinCodeInputView.center = view.center
        pinCodeInputView.set(font: .systemFont(ofSize: 28, weight: .bold))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tap() {
        pinCodeInputView.resignFirstResponder()
    }
    
}
