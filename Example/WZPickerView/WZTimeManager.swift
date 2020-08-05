//
//  WZTimeManager.swift
//  WZPickerView_Example
//
//  Created by xiaobin liu on 2019/8/17.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

/// MARK -  时间数据源
final class WZTimeManager: NSObject {
    
    /// 取消CancelHandler
    public typealias CancelHandler = (_ contentView: WZActionSheetPickerView) -> Void
    
    /// 确定ConfirmHandler
    public typealias ConfirmHandler = (_ contentView: WZActionSheetPickerView, _ result: String) -> Void
    
    /// 取消回掉
    public var cancelCallBack: CancelHandler?
    
    /// 确定回掉
    public var confirmCallBack: ConfirmHandler?
    
    /// 开始数据
    private(set) lazy var beginDataSource: [String] = {
        var temHeight = (9...23).flatMap { hours in
            return ["00", "30"].map { minutes -> String in
                return "\(hours):\(minutes)"
            }
        }
        return temHeight
    }()
    
    /// 结束数据
    private(set) lazy var endDataSource: [String] = {
        var temData = self.beginDataSource
        temData.removeFirst()
        temData.append("24:00")
        return temData
    }()
    
    /// 开始索引
    public var beginIndex: Int = 0
    
    /// 结束索引
    public var endIndex: Int = 0
    
    deinit {
        debugPrint("释放\(String(describing: self))")
    }
}


// MARK: - WZActionSheetPickerViewDataSource
extension WZTimeManager: WZActionSheetPickerViewDataSource {
    
    var title: NSAttributedString? {
        
        return NSAttributedString(string: "直播时间", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
                                                                       NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    var unitAttributedText: NSAttributedString? {
        return NSAttributedString(string: "")
    }
    
    func pickerContentView(_ contentView: WZActionSheetPickerView, widthForComponent component: Int) -> CGFloat {
        return 120
    }
    
    func numberOfComponents(in contentView: WZActionSheetPickerView) -> Int {
        return 2
    }
    
    func pickerContentView(_ contentView: WZActionSheetPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return beginDataSource.count
        case 1:
            return endDataSource.count
        default:
            return 0
        }
    }
    
    func pickerContentView(_ contentView: WZActionSheetPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        
        switch component {
        case 0:
            return beginDataSource[row]
        case 1:
            return endDataSource[row]
        default:
            return ""
        }
    }
}


// MARK: - WZActionSheetPickerViewDelegate
extension WZTimeManager: WZActionSheetPickerViewDelegate {
    
    func pickerContentView(_ contentView: WZActionSheetPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        switch component {
        case 0:
            beginIndex = row
            if endIndex < beginIndex {
                endIndex = beginIndex
                contentView.selectRow(endIndex, inComponent: 1, animated: true)
            }
        default:
            if row < beginIndex {
                endIndex = beginIndex
                contentView.selectRow(endIndex, inComponent: 1, animated: true)
                return
            }
            endIndex = row
        }
    }
    
    func prickerConfim(_ contentView: WZActionSheetPickerView) {
        contentView.dismiss()
        confirmCallBack?(contentView, "\(beginDataSource[beginIndex])-\(endDataSource[endIndex])")
    }
    
    func prickerCancel(_ contentView: WZActionSheetPickerView) {
        contentView.dismiss()
        cancelCallBack?(contentView)
    }
}
