//
//  ItemType.swift
//  PinCodeInputView
//
//  Created by Jinsei Shima on 2018/11/17.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import Foundation

public protocol ItemType {
    
    var text: Character? { get set }
    var isHiddenCursor: Bool { get set }
    func set(appearance: ItemAppearance)
}
