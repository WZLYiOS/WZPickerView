//
//  WZActionSheetHeaderView.swift
//  WZPickerView_Example
//
//  Created by xiaobin liu on 2019/8/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - 头部View协议
public protocol WZActionSheetHeaderViewDelegate: NSObjectProtocol {
    
    /// 取消
    func headerViewCancel(_ headerView: WZActionSheetHeaderView)
    
    /// 确定
    func headerViewConfirm(_ headerView: WZActionSheetHeaderView)
}


/// MARK - WZActionSheetHeaderView
public final class WZActionSheetHeaderView: UIView {
    
    /// 协议
    weak public var delegate: WZActionSheetHeaderViewDelegate?
    
    /// 取消标题
    @objc public dynamic var cancelTitle: String = "取消" {
        didSet {
            self.cancelButton.setTitle(cancelTitle, for: .normal)
        }
    }
    
    /// 取消按钮默认颜色
    @objc public dynamic var cancelNormalColor: UIColor = UIColor.red {
        didSet {
            self.cancelButton.setTitleColor(cancelNormalColor, for: .normal)
        }
    }
    
    /// 取消按钮选中状态颜色
    @objc public dynamic var cancelHighlightedColor: UIColor = UIColor.red {
        didSet {
            self.cancelButton.setTitleColor(cancelHighlightedColor, for: .highlighted)
        }
    }
    
    /// 确定标题
    @objc public dynamic var confirmTitle: String = "确定" {
        didSet {
            self.confirmButton.setTitle(confirmTitle, for: .normal)
        }
    }
    
    /// 确定按钮默认状态颜色
    @objc public dynamic var confirmNormalColor: UIColor = UIColor.black {
        didSet {
            self.confirmButton.setTitleColor(confirmNormalColor, for: .normal)
        }
    }
    
    /// 确定按钮选中状态颜色
    @objc public dynamic var confirmHighlightedColor: UIColor = UIColor.black {
        didSet {
            self.confirmButton.setTitleColor(confirmHighlightedColor, for: .highlighted)
        }
    }
    
    /// 线的颜色
    @objc public dynamic var lineColor: UIColor = UIColor(red: 214/255.0, green: 214/255.0, blue: 214/255.0, alpha: 1.0) {
        didSet {
            self.topLine.backgroundColor = lineColor
            self.bottomLine.backgroundColor = lineColor
        }
    }
    
    /// 标题
    @objc public dynamic var title: NSAttributedString? {
        didSet {
            self.titleLabel.attributedText = title
        }
    }
    
    
    /// 取消按钮
    private lazy var cancelButton: UIButton = {
        
        let temButton = UIButton(type: .custom)
        temButton.setTitle(self.cancelTitle, for: .normal)
        temButton.setTitleColor(self.cancelNormalColor, for: .normal)
        temButton.setTitleColor(self.cancelHighlightedColor, for: .highlighted)
        temButton.addTarget(self, action: #selector(self.eventForCancel), for: .touchUpInside)
        temButton.translatesAutoresizingMaskIntoConstraints = false
        return temButton
    }()
    
    /// 标题
    private lazy var titleLabel: UILabel = {
        let temLabel = UILabel()
        temLabel.translatesAutoresizingMaskIntoConstraints = false
        return temLabel
    }()
    
    /// 确定按钮
    private lazy var confirmButton: UIButton = {
        
        let temButton = UIButton(type: .custom)
        temButton.setTitle(self.confirmTitle, for: .normal)
        temButton.setTitleColor(self.confirmNormalColor, for: .normal)
        temButton.setTitleColor(self.confirmHighlightedColor, for: .highlighted)
        temButton.addTarget(self, action: #selector(self.eventForConfirm), for: .touchUpInside)
        temButton.translatesAutoresizingMaskIntoConstraints = false
        return temButton
    }()
    
    /// 头部线
    private lazy var topLine: UILabel = {
        
        let temLabel = UILabel()
        temLabel.backgroundColor = self.lineColor
        temLabel.translatesAutoresizingMaskIntoConstraints = false
        return temLabel
    }()
    
    /// 底部线
    private lazy var bottomLine: UILabel = {
        
        let temLabel = UILabel()
        temLabel.backgroundColor = self.lineColor
        temLabel.translatesAutoresizingMaskIntoConstraints = false
        return temLabel
    }()
    
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        configView()
        configLocation()
    }
    
    /// 取消事件
    @objc private func eventForCancel() {
        
        self.delegate?.headerViewCancel(self)
    }
    
    /// 确定事件
    @objc private func eventForConfirm() {
        
        self.delegate?.headerViewConfirm(self)
    }
    
    /// 配置View
    private func configView() {
        
        addSubview(topLine)
        addSubview(cancelButton)
        addSubview(confirmButton)
        addSubview(titleLabel)
        addSubview(bottomLine)
    }
    
    /// 配置位置
    private func configLocation() {
        
        cancelButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        confirmButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        confirmButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        topLine.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        topLine.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        topLine.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topLine.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale).isActive = true
        
        bottomLine.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomLine.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalTo: topLine.heightAnchor).isActive = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

