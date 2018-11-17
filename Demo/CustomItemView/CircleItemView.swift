//
//  CircleItemView.swift
//  Demo
//
//  Created by Jinsei Shima on 2018/11/17.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import UIKit
import PinCodeInputView

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
    
    func set(appearance: ItemAppearance) {
        
        label.font = appearance.font
        label.textColor = appearance.textColor
        
        layer.borderColor = appearance.textColor.cgColor
        layer.borderWidth = 1
        
        layoutIfNeeded()
    }
    
}
