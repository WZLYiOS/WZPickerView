//
//  WZShowActionSheetView.swift
//  Pods-WZAlertViewController_Example
//
//  Created by xiaobin liu on 2019/8/7.
//

import UIKit


/// MARK - WZShowAlertViewDelegate
public protocol WZShowAlertViewDelegate: NSObjectProtocol {
    
    /// 将要展示
    func actionSheetWillShow(_ sheet: WZShowAlertView)
    /// 已经展示
    func actionSheetDidShow(_ sheet: WZShowAlertView)
    /// 将要隐藏
    func actionSheetWillDismiss(_ sheet: WZShowAlertView)
}


// MARK: - 协议扩展默认实现
extension WZShowAlertViewDelegate {
    
    func actionSheetWillShow(_ sheet: WZShowAlertView) { }
    func actionSheetDidShow(_ sheet: WZShowAlertView) { }
    func actionSheetWillDismiss(_ sheet: WZShowAlertView) { }
}


/// MARK - WZShowAlertView
public final class WZShowAlertView: UIView {
    
    /// 协议
    public weak var delegate: WZShowAlertViewDelegate?
    
    /// 背景视图
    internal lazy var backgroundView: UIView = {
        let temView = UIView()
        temView.alpha = 0.0
        temView.addGestureRecognizer(self.singleTap)
        return temView
    }()
    
    /// 点击手势
    private lazy var singleTap: UITapGestureRecognizer = {
        let temSingleTap = UITapGestureRecognizer(target: self, action: #selector(singleTap(sender:)))
        temSingleTap.isEnabled = backgoundTapDismissEnable
        return temSingleTap
    }()
    
    /// 背景点击隐藏是否启用(默认为false)
    public var backgoundTapDismissEnable: Bool = false {
        didSet {
            self.singleTap.isEnabled = backgoundTapDismissEnable
        }
    }
    
    /// 是否遮照
    public var isShowMask: Bool = true {
        didSet {
            if self.isShowMask {
                self.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
            } else {
                self.backgroundView.backgroundColor = UIColor.clear
            }
        }
    }
    
    /// 弹出风格
    public var alertStyle: WZAlertStyle = .alert(animateType: .scale(from: 0, to: 1))
    
    /// 默认显示为Y轴中心点(只对Alert样式有效)
    public var alertViewOriginY: CGFloat = 0
    
    /// 弹出视图边距(默认为: 0)
    public var alertViewEdging: CGFloat = 0
    
    /// 内容视图
    private(set) weak var contentView: UIView!
    /// 内容视图高度
    internal var contentViewHeight: CGFloat = 0
    /// 内容视图宽度
    internal var contentViewWidth: CGFloat = 0
    
    /// 初始化弹出视图
    ///
    /// - Parameter contentView: 内容视图
    public convenience init(contentView: UIView) {
        self.init(frame: CGRect.zero)
        self.contentView = contentView
        configView()
        configLocation()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// 手指点击事件
    @objc private func singleTap(sender: UITapGestureRecognizer) {
        dismiss()
    }

    deinit {
        debugPrint("释放WZShowActionSheetView")
    }
}
