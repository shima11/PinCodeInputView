//
//  ItemView.swift
//  PinCodeInputView
//
//  Created by Jinsei Shima on 2018/11/17.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import UIKit

// Default Item View

@IBDesignable
public class ItemView: UIView, ItemType {
    
    public var text: Character? = nil {
        didSet {
            guard let text = text else {
                label.text = nil
                return
            }
            label.text = String(text)
        }
    }
    
    public var isHiddenCursor: Bool = true {
        didSet {
            cursor.isHidden = isHiddenCursor
        }
    }
    
    public let label: UILabel = .init()
    public let cursor: UIView = .init()
    
    public init() {
        
        super.init(frame: .zero)
        
        addSubview(label)
        addSubview(cursor)
        
        clipsToBounds = true
        
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        
        cursor.isHidden = true
        
        UIView.animateKeyframes(
            withDuration: 1.6,
            delay: 0.8,
            options: [.repeat],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 0.2,
                    animations: {
                        self.cursor.alpha = 0
                })
                UIView.addKeyframe(
                    withRelativeStartTime: 0.8,
                    relativeDuration: 0.2,
                    animations: {
                        self.cursor.alpha = 1
                })
        },
            completion: nil
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = bounds
        
        let width: CGFloat = 2
        let height: CGFloat = bounds.height * 0.6
        
        cursor.frame = CGRect(
            x: (bounds.width - width) / 2,
            y: (bounds.height - height) / 2,
            width: width,
            height: height
        )
    }
    
    public func set(appearance: ItemAppearance) {
        bounds.size = appearance.itemSize
        label.font = appearance.font
        label.textColor = appearance.textColor
        cursor.backgroundColor = appearance.cursorColor
        backgroundColor = appearance.backgroundColor
        layer.cornerRadius = appearance.cornerRadius
        layoutIfNeeded()
    }
}
