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
        pinCodeInputView.set(
            appearance: .init(
                font: .systemFont(ofSize: 28, weight: .bold),
                textColor: .white, backgroundColor: UIColor.black.withAlphaComponent(0.3),
                cursorColor: UIColor(red: 69/255, green: 108/255, blue: 1, alpha: 1)
            )
        )
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tap() {
        pinCodeInputView.resignFirstResponder()
    }
    
}
