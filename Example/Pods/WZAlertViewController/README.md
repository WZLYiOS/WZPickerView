# 我主良缘弹方便快捷的弹出框


## Requirements:
- **iOS** 9.0+
- Xcode 10.0+
- Swift 5.0+


## Installation Cocoapods
<pre><code class="ruby language-ruby">pod 'WZAlertViewController', '~> 1.0.0'</code></pre>

## Usage

```swift
         let autolatoutView = WZAutolatoutView()
        WZShowAlertView.showAlertView(alertStyle: type,
                                      showInView: self.view,
                                      contentView: autolatoutView,
                                      backgoundTapDismissEnable: true,
                                      isShowMask: true,
                                      alertViewEdging: 20,
                                      alertViewOriginY: 0, delegate: self)
```

## License
WZAlertViewController is released under an MIT license. See [LICENSE](LICENSE) for more information.
