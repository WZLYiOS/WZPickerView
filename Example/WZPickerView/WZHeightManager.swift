//
//  WZHeightManager.swift
//  WZPickerView_Example
//
//  Created by xiaobin liu on 2019/8/17.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


/// MARK -  身高数据源
final class WZHeightManager: NSObject {
    
    /// 取消CancelHandler
    public typealias CancelHandler = (_ contentView: WZActionSheetPickerView) -> Void
    
    /// 确定ConfirmHandler
    public typealias ConfirmHandler = (_ contentView: WZActionSheetPickerView, _ result: String) -> Void
    
    /// 取消回掉
    public var cancelCallBack: CancelHandler?
    
    /// 确定回掉
    public var confirmCallBack: ConfirmHandler?
    
    /// 身高
    private var heightData: [(key: Int, value: String)] {
        var temHeight = [Int: String]()
        temHeight[0] = "不限"
        Array(stride(from: 150, to: 275, by: 5))
            .forEach {
                temHeight[$0] = "\($0)"
        }
        return temHeight.sorted { $0.0 < $1.0 }
    }
    
    ///默认选择
    public var defaultIndex: Int = 0 {
        didSet {
            if defaultIndex < 0 {
                self.selectIndex = 0
                return
            }
            self.selectIndex = defaultIndex
        }
    }
    /// 选中索引
    private var selectIndex: Int = 0
    
    deinit {
        debugPrint("释放\(String(describing: self))")
    }
}


// MARK: - WZActionSheetPickerViewDataSource
extension WZHeightManager: WZActionSheetPickerViewDataSource {
    
    var title: NSAttributedString? {
        
        return NSAttributedString(string: "身高", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
                                                                 NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    var unitAttributedText: NSAttributedString? {
        return NSAttributedString(string: "厘米", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
                                                                 NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                 NSAttributedString.Key.backgroundColor: UIColor.clear])
    }
    
    func pickerDefaultSelected(_ contentView: WZActionSheetPickerView) {
        contentView.selectRow(self.selectIndex, inComponent: 0, animated: true)
    }
    
    func numberOfComponents(in contentView: WZActionSheetPickerView) -> Int {
        return 1
    }
    
    func pickerContentView(_ contentView: WZActionSheetPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.heightData.count
    }
    
    func pickerContentView(_ contentView: WZActionSheetPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return self.heightData[row].value
    }
    
    func pickerContentView(_ contentView: WZActionSheetPickerView, unitOffsetForComponent component: Int) -> CGFloat {
        
        guard heightData.count > 0 else {
            return 25
        }
        
        let attributes = selectedAttributes
        let itemWidth = contentView.dataSource?.pickerContentView(contentView, widthForComponent: component) ?? 0
        let rowHeight = contentView.dataSource?.pickerContentView(contentView, rowHeightForComponent: component) ?? 0
        return NSAttributedString(string: "\(self.heightData[0].value)", attributes: attributes ?? [:])
            .boundingRect(with: CGSize(width: itemWidth,
                                       height: rowHeight),
                          options: .usesLineFragmentOrigin,
                          context: nil)
            .width / 2 + 8
    }
}


// MARK: - WZActionSheetPickerViewDelegate
extension WZHeightManager: WZActionSheetPickerViewDelegate {
    
    func pickerContentView(_ contentView: WZActionSheetPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectIndex = row
    }
    
    func prickerConfim(_ contentView: WZActionSheetPickerView) {
        contentView.dismiss()
        confirmCallBack?(contentView, heightData[selectIndex].value)
    }
    
    func prickerCancel(_ contentView: WZActionSheetPickerView) {
        contentView.dismiss()
        cancelCallBack?(contentView)
    }
}

