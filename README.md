# PinCodeInputView
A text input view for entering pin code. 

![](demo.png)

## Features

- something...

## Getting Started


![](description1.png)

### View Hierarchy

SurfaceView is used to detect a user gesture.
ItemView is Appearance. You can customize ItemView.

![](description2.png)

```swift
private class ContainerItemView<T: UIView & ItemType>: UIView {
    var itemView: T
    private let surfaceView: UIView = .init()
    private var didTapHandler: (() -> ())?
}
```

To create your customize ItemView, you create a view conforming to ItemType.
```swift
public protocol ItemType {
    var text: Character? { get set }
    var isHiddenCursor: Bool { get set }
    func set(appearance: Appearance)
}
```

About  to set appearance.
```swift
public struct Appearance { }

pinCodeInputView.set(appearance: )
```


## Usage


```swift
import PinCodeInputView
```

### standard
```swift

// initialize
let pinCodeInputView: PinCodeInputView<ItemView> = .init(
    digit: 6,
    itemSpacing: 8,
    itemFactory: {
    return ItemView()
})

view.addSubview(pinCodeInputView)

// set appearance
pinCodeInputView.set(
    appearance: .init(
        itemSize: .init(width: 44, height: 68),
        font: .systemFont(ofSize: 28, weight: .bold),
        textColor: .white,
        backgroundColor: .darkGray,
        cursorColor: .blue,
        cornerRadius: 8
    )
)

// text handling
pinCodeInputView.set(changeTextHandler: { text in
    print(text)
})
```

### customize

```swift
final class CustomItemView: UIView, ItemType {
    var text: Character?
    var isHiddenCursor: Bool
    func set(appearance: Appearance) {}
    
    // ...
}

let pinCodeInputView: PinCodeInputView<CustomItemView> = .init(
    digit: 6,
    itemSpacing: 8,
    itemFactory: {
    return CustomItemView()
})
```

## Installation

### Carthage

For Installing with Carthage, and add it to your `Cartfile`.

````
github "shima11/PinCodeInputView"
````
````
$ carthage update
````

### CocoaPods

For installing with CocoaPods, and add it to your `Podfile`.
```
pod "PinCodeInputView"
```
```
$ pod update
```


## License

Licence MIT
