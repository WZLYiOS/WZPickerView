# 我主良缘WZPickerView

## Requirements:
- **iOS** 9.0+
- Xcode 10.0+
- Swift 5.0+


## Installation Cocoapods
<pre><code class="ruby language-ruby">pod 'WZPickerView', '~> 2.0.0'</code></pre>

## Use

```swift

    /// 身高数据源
    private lazy var heightManager: WZHeightManager = {
        let temHeightDataSource = WZHeightManager()
        temHeightDataSource.defaultIndex = 2//默认选中第二个
        return temHeightDataSource
    }()
    private var heightValue = ""
    
    /// 时间数据源
    private lazy var timeManager: WZTimeManager = {
        let temTimeManager = WZTimeManager()
        return temTimeManager
    }()
    private var timeValue = ""
    
    /// 区域
    private lazy var areaManager: WZAreaManager = {
        let temAreaManager = WZAreaManager(type: .provinceCityArea)
        return temAreaManager
    }()
    private var areaValue = ""
    
    /// 显示
    private lazy var actionSheetPickerView: WZActionSheetPickerView = {
        let temActionSheetPickerView = WZActionSheetPickerView()
        return temActionSheetPickerView
    }()
```

```swift
 详情请看Demo
```


## License
WZPickerView is released under an MIT license. See [LICENSE](LICENSE) for more information.
