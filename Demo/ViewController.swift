//
//  ViewController.swift
//  PinCodeInputView
//
//  Created by Jinsei Shima on 2018/11/05.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import UIKit
import PinCodeInputView


final class UnderlineItemView: UIView, ItemType {

    var text: Character? = nil {
        didSet {
            guard let text = text else {
                label.text = nil
                return
            }
            label.text = String(text)
        }
    }

    var isHiddenCursor: Bool = false

    private let label: UILabel = .init()
    private let underLineView: UIView = .init()

    init() {

        super.init(frame: .zero)

        addSubview(label)
        addSubview(underLineView)

        clipsToBounds = true

        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        
        underLineView.backgroundColor = .lightText

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds

        let width: CGFloat = bounds.width
        let height: CGFloat = 2
        
        underLineView.frame = CGRect(
            x: (bounds.width - width) / 2,
            y: (bounds.height - height),
            width: width,
            height: height
        )
    }
    
    func set(appearance: Appearance) {
        
        label.font = appearance.font
        label.textColor = appearance.textColor
        layoutIfNeeded()
    }

}

final class CircleItemView: UIView, ItemType {
    
    var text: Character? = nil {
        didSet {
            guard let text = text else {
                label.text = nil
                return
            }
            label.text = String(text)
        }
    }
    
    var isHiddenCursor: Bool = false
    
    private let label: UILabel = .init()
    
    init() {
        
        super.init(frame: .zero)
        
        addSubview(label)
        
        clipsToBounds = true
        
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let length = min(bounds.width, bounds.height)
        frame = CGRect(x: 0, y: 0, width: length, height: length)
        layer.cornerRadius = length / 2
        label.frame = bounds
    }
    
    func set(appearance: Appearance) {
        
        label.font = appearance.font
        label.textColor = appearance.textColor
        
        layer.borderColor = appearance.textColor.cgColor
        layer.borderWidth = 1
        
        layoutIfNeeded()
    }
    
}

final class PasswordItemView: UIView, ItemType {
    
    var text: Character? = nil {
        didSet {
            guard let _ = text else {
                backgroundColor = .clear
                return
            }
            backgroundColor = appearance?.textColor
        }
    }
    
    var isHiddenCursor: Bool = false
    private var appearance: Appearance?
    
    init() {
        
        super.init(frame: .zero)
        
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let appearance = appearance else { return }
        let length = min(appearance.itemSize.width, appearance.itemSize.height)
        frame = CGRect(x: 0, y: 0, width: length, height: length)
        layer.cornerRadius = length / 2
    }
    
    func set(appearance: Appearance) {
        self.appearance = appearance
        
        bounds.size = appearance.itemSize
        layer.borderColor = appearance.textColor.cgColor
        layer.borderWidth = 1
        
        layoutIfNeeded()
    }
    
}



class ViewController: UIViewController {

    // default item view
    let pinCodeInputView: PinCodeInputView<ItemView> = .init(
        digit: 6,
        itemSpacing: 8,
        itemFactory: {
            return ItemView()
    })

    // customize item view
//    let pinCodeInputView: PinCodeInputView<UnderlineItemView> = .init(
//        digit: 6,
//        itemFactory: {
//        return UnderlineItemView()
//    })

//    let pinCodeInputView: PinCodeInputView<CircleItemView> = .init(
//        digit: 6,
//        itemFactory: {
//            return CircleItemView()
//    })

//    let pinCodeInputView: PinCodeInputView<PasswordItemView> = .init(
//        digit: 4,
//        itemFactory: {
//            return PasswordItemView()
//    })

    let titleLabel = UILabel()

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
