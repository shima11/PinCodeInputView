//
//  PasswordItemView.swift
//  Demo
//
//  Created by Jinsei Shima on 2018/11/17.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import UIKit
import PinCodeInputView

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
    private var appearance: ItemAppearance?
    
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
    
    func set(appearance: ItemAppearance) {
        self.appearance = appearance
        
        bounds.size = appearance.itemSize
        layer.borderColor = appearance.textColor.cgColor
        layer.borderWidth = 1
        
        layoutIfNeeded()
    }
    
}
