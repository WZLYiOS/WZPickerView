//
//  WZShowAlertView+Animation.swift
//  WZAlertViewController_Example
//
//  Created by xiaobin liu on 2019/8/11.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Foundation


// MARK: - WZShowAlertView+Animation
extension WZShowAlertView {
    
    /// 弹窗动画
    ///
    /// - Parameters:
    ///   - animateType: 动画类型
    ///   - isShow: 是否是显示
    internal func alertAnimateType(_ animateType: WZAlertAnimateType, isShow: Bool) {
        switch animateType {
        case let .alpha(from, to):
            animateAlpha(from: from, to: to, isShow: isShow)
        case let .scale(from, to):
            animationScale(form: from, to: to, isShow: isShow)
        case let .direction(type):
            animationDirection(type, isShow: isShow)
        }
    }
    
    /// alertAnimation
    ///
    /// - Parameters:
    ///   - animations: animations
    ///   - completion: completion
    private func alertAnimation(animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.38, animations: animations, completion: completion)
    }
    
    
    /// 方向CGAffineTransform
    ///
    /// - Parameters:
    ///   - type: type description
    ///   - frame: frame description
    /// - Returns: return value description
    private func direction(type: WZDirectionType, frame: CGRect) -> CGAffineTransform {
        
        switch type {
        case .left:
            return CGAffineTransform(translationX: -frame.width, y: 0)
        case .right:
            return CGAffineTransform(translationX: frame.width, y: 0)
        case .top:
            return CGAffineTransform(translationX: 0, y: -frame.height)
        case .bottom:
            return CGAffineTransform(translationX: 0, y: frame.height)
        }
    }
    
    /// 显示动画完成
    private func showAnimationFinish() {
        self.delegate?.actionSheetDidShow(self)
    }
    
    /// 隐藏动画完成
    private func dismissAnimationFinish() {
        self.contentView.transform = .identity
        self.removeFromSuperview()
    }
    
    /// 动画Alpha
    ///
    /// - Parameters:
    ///   - from: from description
    ///   - to: to description
    ///   - isShow: isShow description
    private func animateAlpha(from: CGFloat ,to: CGFloat, isShow: Bool) {
        
        if isShow {
            contentView.alpha = from
            alertAnimation(animations: {
                self.contentView.alpha = to
                self.backgroundView.alpha = 1
            }) { (finish) in
                self.showAnimationFinish()
            }
        } else {
            
            alertAnimation(animations: {
                self.contentView.alpha = from
                self.backgroundView.alpha = 0
            }) { (finish) in
                self.dismissAnimationFinish()
            }
        }
    }
    
    
    /// 动画Scale
    ///
    /// - Parameters:
    ///   - form: form description
    ///   - to: to description
    ///   - isShow: isShow description
    private func animationScale(form: CGFloat, to: CGFloat, isShow: Bool) {
        
        let transform: CGAffineTransform = CGAffineTransform(scaleX: form, y: form)
        if isShow {
            self.contentView.transform = transform
            alertAnimation(animations: {
                self.contentView.transform = .identity
                self.backgroundView.alpha = 1
            }) { (finish) in
                self.showAnimationFinish()
            }
        } else {
            
            alertAnimation(animations: {
                self.contentView.transform = transform
                self.backgroundView.alpha = 0
            }) { (finish) in
                self.dismissAnimationFinish()
            }
        }
    }
    
    
    /// 动画方向
    ///
    /// - Parameters:
    ///   - constant: constant description
    ///   - isShow: 是否是显示
    internal func animationDirection(_ directionType: WZDirectionType, isShow: Bool) {
        
        var temFrame = CGRect.zero
        switch alertStyle {
        case .alert:
            temFrame = CGRect(x: 0, y: 0, width: contentViewWidth + alertViewEdging, height: frame.height)
        default:
            temFrame = CGRect(x: 0, y: 0, width: contentViewWidth, height: contentViewHeight)
        }
        
        
        if isShow {
            
            contentView.transform = direction(type: directionType, frame: temFrame)
            alertAnimation(animations: {
                self.contentView.transform = .identity
                self.backgroundView.alpha = 1
            }) { (finish) in
                self.showAnimationFinish()
            }
        } else {
            
            alertAnimation(animations: {
                self.contentView.transform = self.direction(type: directionType, frame: temFrame)
                self.backgroundView.alpha = 0
            }) { (finish) in
                self.dismissAnimationFinish()
            }
        }
    }
}
