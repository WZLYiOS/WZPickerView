//
//  ViewController.swift
//  WZPickerView
//
//  Created by LiuSky on 08/16/2019.
//  Copyright (c) 2019 LiuSky. All rights reserved.
//

import UIKit

/// 类型
enum ActionSheetType: CaseIterable {
    case height
    case time
    case area
}


// MARK: - CustomStringConvertible
extension ActionSheetType: CustomStringConvertible {
    var description: String {
        switch self {
        case .height:
            return "身高"
        case .time:
            return "时间"
        case .area:
            return "区域"
        }
    }
}


/// MARK - Demo
final class ViewController: UIViewController {

    /// 身高数据源
    private lazy var heightManager: WZHeightManager = {
        let temHeightDataSource = WZHeightManager()
        temHeightDataSource.defaultIndex = 2//默认选中第二个
        return temHeightDataSource
    }()
    private var heightValue = ""
    
    /// 时间数据源
    private lazy var timeManager: WZTimeManager = {
        let temTimeManager = WZTimeManager()
        return temTimeManager
    }()
    private var timeValue = ""
    
    /// 区域
    private lazy var areaManager: WZAreaManager = {
        let temAreaManager = WZAreaManager(type: .provinceCityArea)
        return temAreaManager
    }()
    private var areaValue = ""
    
    /// 显示
    private lazy var actionSheetPickerView: WZActionSheetPickerView = {
        let temActionSheetPickerView = WZActionSheetPickerView()
        return temActionSheetPickerView
    }()
    
    /// 列表
    private lazy var tableView: UITableView = {
        let temTableView = UITableView()
        temTableView.rowHeight = 50
        temTableView.dataSource = self
        temTableView.delegate = self
        temTableView.tableFooterView = UIView()
        temTableView.separatorInset = .zero
        temTableView.register(WZTableViewCell.self, forCellReuseIdentifier: String(describing: WZTableViewCell.self))
        temTableView.translatesAutoresizingMaskIntoConstraints = false
        return temTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "演示Demo"
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        configHeightCallBack()
        configTimeCallBack()
        configAreaCallBack()
    }
    
    
    /// 配置高度回调
    private func configHeightCallBack() {
        
        heightManager.cancelCallBack = { view in
            debugPrint("取消")
        }
        
        heightManager.confirmCallBack = { [weak self] (view, result) in
            guard let self = self else {
                return
            }
            self.heightValue = result
            self.tableView.reloadData()
        }
    }
    
    /// 配置时间回调
    private func configTimeCallBack() {
        
        timeManager.cancelCallBack = { view in
            debugPrint("取消")
        }
        
        timeManager.confirmCallBack = { [weak self] (view, result) in
            guard let self = self else {
                return
            }
            self.timeValue = result
            self.tableView.reloadData()
        }
    }
    
    /// 配置区域
    private func configAreaCallBack() {
        areaManager.cancelCallBack = { view in
            debugPrint("取消")
        }
        
        areaManager.confirmCallBack = { [weak self] (view, result) in
            guard let self = self else {
                return
            }
            self.areaValue = result
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ActionSheetType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WZTableViewCell.self), for: indexPath)
        switch ActionSheetType.allCases[indexPath.row] {
        case .height:
            cell.detailTextLabel?.text = heightValue
        case .time:
            cell.detailTextLabel?.text = timeValue
        case .area:
            cell.detailTextLabel?.text = areaValue
        }
        cell.textLabel?.text = ActionSheetType.allCases[indexPath.row].description
        return cell
    }
}


// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        switch ActionSheetType.allCases[indexPath.row] {
        case .height:
            self.actionSheetPickerView.dataSource = self.heightManager
            self.actionSheetPickerView.delegate = self.heightManager
        case .time:
            self.actionSheetPickerView.dataSource = self.timeManager
            self.actionSheetPickerView.delegate = self.timeManager
        case .area:
            self.actionSheetPickerView.dataSource = self.areaManager
            self.actionSheetPickerView.delegate = self.areaManager
        }
        
        self.actionSheetPickerView.show()
    }
}



/// UITableViewCell
final class WZTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
