//
//  WZPickerView.swift
//  WZPickerView_Example
//
//  Created by xiaobin liu on 2019/8/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - WZPickerView
public class WZPickerView: UIPickerView {
    
    /// 单位标签
    private lazy var unitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// 单边标签左边距离
    public var unitLabelLeftConstraint: NSLayoutConstraint?
    
    /// 选中属性
    public var selectedAttributes: [NSAttributedString.Key : Any]?
    
    /// 单位富文本
    public var unitAttributedText: NSAttributedString? {
        didSet {
            self.unitLabel.backgroundColor = UIColor.clear
            self.unitLabel.attributedText = unitAttributedText
        }
    }
    
    /// 灰色的线
    public var lineColor: UIColor? = UIColor(red: 183.0/255.0, green: 183.0/255.0, blue: 183.0/255.0, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSubviews()
    }
    
    /// 配置视图
    private func configureSubviews() {
        backgroundColor = UIColor.white
        addSubview(unitLabel)
        self.unitLabelLeftConstraint = unitLabel.leftAnchor.constraint(equalTo: centerXAnchor, constant: 0)
        self.unitLabelLeftConstraint?.isActive = true
        unitLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 1.5).isActive = true
    }
    
    /// UITableViewDataSource
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = super.tableView(tableView, cellForRowAt: indexPath)
        if tableView.superview === tableView.superview?.superview?.subviews.last {
            
            var label: UILabel?
            for view in tableViewCell.subviews {
                if let temView = view as? UILabel {
                    label = temView
                    break
                }
            }
            label?.font = selectedAttributes?[.font] as? UIFont
            label?.textColor = selectedAttributes?[.foregroundColor] as? UIColor
        }
        return tableViewCell
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let temLineColor = lineColor else {
            return
        }
        
        for item in self.subviews {
            if item.frame.size.height < 1 {
                item.backgroundColor = temLineColor
            }
        }
    }
}

