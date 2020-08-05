//
//  WZActionSheetPickerViewDelegate.swift
//  WZPickerView_Example
//
//  Created by xiaobin liu on 2019/8/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


/// MARK - WZActionSheetPickerViewDelegate
public protocol WZActionSheetPickerViewDelegate: NSObjectProtocol {
    
    /// 选中索引
    ///
    /// - Parameters:
    ///   - contentView: contentView description
    ///   - row: row description
    ///   - component: component description
    func pickerContentView(_ contentView: WZActionSheetPickerView, didSelectRow row: Int, inComponent component: Int)
    
    /// 确定
    ///
    /// - Parameter contentView: contentView description
    func prickerConfim(_ contentView: WZActionSheetPickerView)
    
    /// 取消
    ///
    /// - Parameter contentView: contentView description
    func prickerCancel(_ contentView: WZActionSheetPickerView)
}
