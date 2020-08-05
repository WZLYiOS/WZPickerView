//
//  AlertAnimateType.swift
//  WZAlertViewController_Example
//
//  Created by xiaobin liu on 2019/8/8.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Foundation

/// 方向类型
public enum WZDirectionType: Int, Equatable, CustomStringConvertible {
    
    case left
    case right
    case top
    case bottom
    
    public var description: String {
        switch self {
        case .left:
            return "Left"
        case .right:
            return "Right"
        case .top:
            return "Top"
        case .bottom:
            return "Bottom"
        }
    }
}

/// 对话框动画类型
public enum WZAlertAnimateType: Equatable, CustomStringConvertible {
    
    case alpha(from: CGFloat , to: CGFloat)
    case scale(from: CGFloat , to: CGFloat)
    case direction(type: WZDirectionType)
    
    public var description: String {
        switch self {
        case .alpha:
            return "Alpha"
        case .scale:
            return "Scale"
        case let .direction(type):
            return type.description
        }
    }
}


/// MARK - 弹出风格
public enum WZAlertStyle: Equatable, CustomStringConvertible {
    
    case alert(animateType: WZAlertAnimateType)
    case actionSheet(directionType: WZDirectionType)
    
    public static func == (lhs: WZAlertStyle, rhs: WZAlertStyle) -> Bool {
        switch (lhs, rhs) {
        case let  (.alert(lValue), .alert(rValue)):
            return lValue == rValue
        case let (.actionSheet(lValue), .actionSheet(rValue)):
            return lValue == rValue
        default:
            return false
        }
    }
    
    public var description: String {
        switch self {
        case let .alert(animateType):
            return "Alert" + animateType.description
        case let .actionSheet(directionType):
            return "ActionSheet" + directionType.description
        }
    }
}


// MARK: - CaseIterable
extension WZAlertStyle: CaseIterable {
    
    public static var allCases: [WZAlertStyle] {
        return [WZAlertStyle.alert(animateType: WZAlertAnimateType.alpha(from: 0, to: 1)),
                WZAlertStyle.alert(animateType: WZAlertAnimateType.scale(from: 0.00001, to: 1)),
                WZAlertStyle.alert(animateType: WZAlertAnimateType.direction(type: WZDirectionType.left)),
                WZAlertStyle.alert(animateType: WZAlertAnimateType.direction(type: WZDirectionType.right)),
                WZAlertStyle.alert(animateType: WZAlertAnimateType.direction(type: WZDirectionType.top)),
                WZAlertStyle.alert(animateType: WZAlertAnimateType.direction(type: WZDirectionType.bottom)),
                WZAlertStyle.actionSheet(directionType: WZDirectionType.left),
                WZAlertStyle.actionSheet(directionType: WZDirectionType.right),
                WZAlertStyle.actionSheet(directionType: WZDirectionType.top),
                WZAlertStyle.actionSheet(directionType: WZDirectionType.bottom)]
    }
}
