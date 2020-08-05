//
//  WZShowAlertView+Layout.swift
//  WZAlertViewController_Example
//
//  Created by xiaobin liu on 2019/8/11.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Foundation


// MARK: - WZShowAlertView+Layout
extension WZShowAlertView {
    
    /// 配置视图
    internal func configView() {
        
        guard let contentView = self.contentView else {
            fatalError("内容视图不能为nil")
        }
        addSubview(contentView)
        insertSubview(backgroundView, at: 0)
    }
    
    /// 配置位置
    internal func configLocation() {
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    /// 视图添加的时候
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let temSuperView = self.superview {
            translatesAutoresizingMaskIntoConstraints = false
            leftAnchor.constraint(equalTo: temSuperView.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: temSuperView.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: temSuperView.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: temSuperView.bottomAnchor).isActive = true
            calculateLayout()
        }
    }
    
    /// 计算布局
    private func calculateLayout() {
        
        guard let contentView = self.contentView else {
            fatalError("内容视图不能为nil")
        }
        
        /// 如果你是用frame布局的话
        if contentView.frame.size != CGSize.zero {
            contentViewHeight = contentView.frame.size.height
            contentViewWidth = contentView.frame.size.width
        } else {
            
            contentViewWidth = superview!.frame.width - alertViewEdging * 2
            let contentViewSize = contentView.systemLayoutSizeFitting(CGSize(width: contentViewWidth, height: 0.0), withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.fittingSizeLevel)
            contentViewHeight = contentViewSize.height
        }
        layoutAlertView()
    }
    
    /// 布局
    private func layoutAlertView() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: contentViewWidth).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: contentViewHeight).isActive = true
        
        switch alertStyle {
        case let .actionSheet(directionType):
            
            switch directionType {
            case .left, .right, .bottom:
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            case .top:
                contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            }
        case .alert:
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: alertViewOriginY).isActive = true
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
}
