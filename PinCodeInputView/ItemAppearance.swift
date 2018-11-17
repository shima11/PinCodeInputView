//
//  ItemAppearance.swift
//  PinCodeInputView
//
//  Created by Jinsei Shima on 2018/11/17.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import Foundation

public struct ItemAppearance {
    
    public let itemSize: CGSize
    public let font: UIFont
    public let textColor: UIColor
    public let backgroundColor: UIColor
    public let cursorColor: UIColor
    public let cornerRadius: CGFloat
    
    public init(
        itemSize: CGSize,
        font: UIFont,
        textColor: UIColor,
        backgroundColor: UIColor,
        cursorColor: UIColor,
        cornerRadius: CGFloat
        ) {
        
        self.itemSize = itemSize
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.cursorColor = cursorColor
        self.cornerRadius = cornerRadius
    }
}
