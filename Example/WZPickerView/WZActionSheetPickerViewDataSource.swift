//
//  WZActionSheetPickerViewDataSource.swift
//  WZPickerView_Example
//
//  Created by xiaobin liu on 2019/8/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - WZActionSheetPickerViewDataSource
public protocol WZActionSheetPickerViewDataSource: NSObjectProtocol {
    
    /// 标题
    var title: NSAttributedString? { get }
    
    /// 选中的富文本
    var selectedAttributes: [NSAttributedString.Key : Any]? { get }
    
    /// 单位富文本
    var unitAttributedText: NSAttributedString? { get }
    
    /// 默认选择
    ///
    /// - Parameter contentView: contentView description
    /// - Returns: return value description
    func pickerDefaultSelected(_ contentView: WZActionSheetPickerView)
    
    /// 多少列
    ///
    /// - Parameter contentView: contentView description
    /// - Returns: return value description
    func numberOfComponents(in contentView: WZActionSheetPickerView) -> Int
    
    /// 每列多少个
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - component: component description
    /// - Returns: return value description
    func pickerContentView(_ contentView: WZActionSheetPickerView, numberOfRowsInComponent component: Int) -> Int

    
    /// 每列宽度是多少
    ///
    /// - Parameters:
    ///   - pickerView: pickerView description
    ///   - component: component description
    /// - Returns: return value description
    func pickerContentView(_ contentView: WZActionSheetPickerView, widthForComponent component: Int) -> CGFloat
    
    
    /// 每列高度是多少
    ///
    /// - Parameters:
    ///   - pickerView: pickerView description
    ///   - component: component description
    /// - Returns: return value description
    func pickerContentView(_ contentView: WZActionSheetPickerView, rowHeightForComponent component: Int) -> CGFloat
    
    
    /// 每一列展示的内容
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    /// - Returns: return value description
    func pickerContentView(_ contentView: WZActionSheetPickerView, titleForRow row: Int, forComponent component: Int) -> String
    
    /// 单位偏移量
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - component: component description
    /// - Returns: return value description
    func pickerContentView(_ contentView: WZActionSheetPickerView, unitOffsetForComponent component: Int) -> CGFloat
}



// MARK: - 默认实现
extension WZActionSheetPickerViewDataSource {
    
    var title: NSAttributedString? {
        return nil
    }
    
    var unitAttributedText: NSAttributedString? {
        return nil
    }
    
    var selectedAttributes: [NSAttributedString.Key : Any]? {
        return [.font: UIFont.systemFont(ofSize: 39), .foregroundColor: UIColor.red]
    }
    
    func pickerDefaultSelected(_ contentView: WZActionSheetPickerView) {
        
    }
    
    func pickerContentView(_ contentView: WZActionSheetPickerView, widthForComponent component: Int) -> CGFloat {
        return 300
    }
    
    func pickerContentView(_ contentView: WZActionSheetPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerContentView(_ contentView: WZActionSheetPickerView, unitOffsetForComponent component: Int) -> CGFloat {
        return 0
    }
}
