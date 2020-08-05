//
//  WZActionSheetPickerView.swift
//  WZPickerView_Example
//
//  Created by xiaobin liu on 2019/8/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import WZPickerView
import WZAlertViewController


/// MARK - WZActionSheetPickerView
open class WZActionSheetPickerView: UIView {

    /// 数据源
    public weak var dataSource: WZActionSheetPickerViewDataSource? {
        didSet {
            self.configDefaultSelect()
            self.headerView.title = self.dataSource?.title
            self.pickerView.selectedAttributes = self.dataSource?.selectedAttributes
            self.pickerView.unitAttributedText = self.dataSource?.unitAttributedText
            self.pickerView.unitLabelLeftConstraint?.constant = self.dataSource?.pickerContentView(self, unitOffsetForComponent: 0) ?? 0.0
        }
    }
    
    /// delegate
    public weak var delegate: WZActionSheetPickerViewDelegate?
    
    /// 头部视图
    private lazy var headerView: WZActionSheetHeaderView = {
        let temHeaderView = WZActionSheetHeaderView()
        temHeaderView.backgroundColor = UIColor.white
        temHeaderView.cancelTitle = "取消"
        temHeaderView.confirmTitle = "确定"
        temHeaderView.delegate = self
        temHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return temHeaderView
    }()
    
    /// pickerView
    private lazy var pickerView: WZPickerView = {
        let temPickerView = WZPickerView()
        temPickerView.backgroundColor = UIColor.white
        temPickerView.dataSource = self
        temPickerView.delegate = self
        temPickerView.translatesAutoresizingMaskIntoConstraints = false
        return temPickerView
    }()
    
    /// 弹出视图
    private var showAlertView: WZShowAlertView?
    
    /// 安全区域距离底部
    private lazy var safeAreaInsetsBottom: CGFloat = {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.rootViewController?.view.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }()
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        configView()
        configLocation()
    }
    
    /// 配置视图
    private func configView() {
        addSubview(headerView)
        addSubview(pickerView)
    }
    
    /// 配置位置
    private func configLocation() {
        
        headerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        pickerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        pickerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        pickerView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -safeAreaInsetsBottom).isActive = true
    }
    
    /// 配置默认选择
    private func configDefaultSelect() {
        self.dataSource?.pickerDefaultSelected(self)
    }
    
    
    /// 配置回调
    fileprivate func configDelegate() {
        
        if pickerView.dataSource == nil {
            pickerView.dataSource = self
        }
        
        if pickerView.delegate == nil {
            pickerView.delegate = self
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("释放\(String(describing: self))")
    }
}


// MARK: - UIPickerViewDataSource
extension WZActionSheetPickerView: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataSource?.numberOfComponents(in: self) ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource?.pickerContentView(self, numberOfRowsInComponent: component) ?? 0
    }
}

// MARK: - UIPickerViewDelegate
extension WZActionSheetPickerView: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return dataSource?.pickerContentView(self, widthForComponent: component) ?? self.frame.width/2
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return dataSource?.pickerContentView(self, rowHeightForComponent: component) ?? 50
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource?.pickerContentView(self, titleForRow: row, forComponent: component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pickerContentView(self, didSelectRow: row, inComponent: component)
    }
}


// MARK: - WZActionSheetHeaderViewDelegate
extension WZActionSheetPickerView: WZActionSheetHeaderViewDelegate {
    
    public func headerViewCancel(_ headerView: WZActionSheetHeaderView) {
        delegate?.prickerCancel(self)
    }
    
    public func headerViewConfirm(_ headerView: WZActionSheetHeaderView) {
        delegate?.prickerConfim(self)
    }
}


// MARK: - show public
extension WZActionSheetPickerView {
    
    /// 显示
    public func show() {
        
       configDelegate()
       showAlertView = WZShowAlertView.showAlertView(alertStyle: .actionSheet(directionType: .bottom),
                                      contentView: self,
                                      backgoundTapDismissEnable: true,
                                      isShowMask: true,
                                      delegate: self)
    }
    
    
    /// 隐藏
    public func dismiss() {
        showAlertView?.dismiss()
        showAlertView = nil
        pickerView.delegate = nil
        pickerView.dataSource = nil
    }
    
    
    /// 选择行数
    ///
    /// - Parameters:
    ///   - row: row description
    ///   - component: component description
    ///   - animated: animated description
    public func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
        
        configDelegate()
        pickerView.selectRow(row, inComponent: component, animated: false)
    }
    
    
    /// 刷新Component
    ///
    /// - Parameter component: component description
    public func reloadComponent(_ component: Int) {
        pickerView.reloadComponent(component)
    }
}


// MARK: - WZShowAlertViewDelegate
extension WZActionSheetPickerView: WZShowAlertViewDelegate {
    
    public func actionSheetWillShow(_ sheet: WZShowAlertView) {}
    public func actionSheetDidShow(_ sheet: WZShowAlertView) {}
    public func actionSheetWillDismiss(_ sheet: WZShowAlertView) {}
}
