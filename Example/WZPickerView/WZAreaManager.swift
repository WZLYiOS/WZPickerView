//
//  WZAreaManager.swift
//  WZPickerView_Example
//
//  Created by xiaobin liu on 2019/8/17.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import CleanJSON

/// 区域类型
///
/// - provincesAndCities: <#provincesAndCities description#>
public enum AreaType: Int {
    case provincesAndCities = 2 //省和市
    case provinceCityArea = 3 //省市区
}


/// MARK - 区域管理
final class WZAreaManager: NSObject {
    
    /// 取消CancelHandler
    public typealias CancelHandler = (_ contentView: WZActionSheetPickerView) -> Void
    
    /// 确定ConfirmHandler
    public typealias ConfirmHandler = (_ contentView: WZActionSheetPickerView, _ result: String) -> Void
    
    /// 取消回掉
    public var cancelCallBack: CancelHandler?
    
    /// 确定回掉
    public var confirmCallBack: ConfirmHandler?
    
    /// 城市数组
    private lazy var dataSource: [ProvinceModel]? = {
       
        guard let path = Bundle.main.path(forResource: "Area", ofType: "txt"),
            let content = try? String(contentsOfFile: path, encoding: .utf8),
            let data = content.data(using: String.Encoding.utf8),
            let result = try? CleanJSONDecoder().decode(Result<[ProvinceModel]>.self, from: data),
            let array = result.data else {
                return nil
        }
        return array
    }()
    
    /// 省选择索引
    public var provincesIndex: Int = 0
    /// 市选择索引
    public var citiesIndex: Int = 0
    /// 区域选择索引
    public var areaIndex: Int = 0
    /// 区域类型
    private let type: AreaType
    
    init(type: AreaType) {
        self.type = type
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("释放\(String(describing: self))")
    }
}


// MARK: - WZActionSheetPickerViewDataSource
extension WZAreaManager: WZActionSheetPickerViewDataSource {
    
    var title: NSAttributedString? {
        
        return NSAttributedString(string: "区域选择", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
                                                                       NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    var unitAttributedText: NSAttributedString? {
        return NSAttributedString(string: "")
    }
    
    func pickerContentView(_ contentView: WZActionSheetPickerView, widthForComponent component: Int) -> CGFloat {
        switch type {
        case .provincesAndCities:
            return UIScreen.main.bounds.size.width/2
        default:
            switch component {
            case 0:
                return 100
            case 1:
                return 100
            case 2:
                return 120
            default:
                return 100
            }
            //return UIScreen.main.bounds.size.width/3
        }
    }
    
    func numberOfComponents(in contentView: WZActionSheetPickerView) -> Int {
       return type.rawValue
    }
    
    func pickerContentView(_ contentView: WZActionSheetPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return self.dataSource?.count ?? 0
        case 1:
            return self.dataSource?[provincesIndex].citys.count ?? 0
        default:
            return self.dataSource?[provincesIndex].citys[citiesIndex].areas?.count ?? 0
        }
    }
    
    func pickerContentView(_ contentView: WZActionSheetPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        
        guard let temDataSource = self.dataSource else {
            return ""
        }
        
        switch component {
        case 0:
            return temDataSource[row].name
        case 1:
            let count = temDataSource[provincesIndex].citys.count
            if count - 1 >= row {
                return temDataSource[provincesIndex].citys[row].name
            } else {
                return temDataSource[provincesIndex].citys[0].name
            }
        default:
            let count = temDataSource[provincesIndex].citys[citiesIndex].areas?.count ?? 0
            if count - 1 >= row {
                return temDataSource[provincesIndex].citys[citiesIndex].areas?[row].name ?? ""
            } else {
                return temDataSource[provincesIndex].citys[citiesIndex].areas?[0].name ?? ""
            }
        }
    }
}


// MARK: - WZActionSheetPickerViewDelegate
extension WZAreaManager: WZActionSheetPickerViewDelegate {
    
    func pickerContentView(_ contentView: WZActionSheetPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            provincesIndex = row
            contentView.reloadComponent(1)
            contentView.selectRow(0, inComponent: 1, animated: true)
            citiesIndex = 0
            areaIndex = 0
            reloadCitysComponent(contentView)
        case 1:
            citiesIndex = row
            areaIndex = 0
            reloadCitysComponent(contentView)
        default:
            areaIndex = row
        }
    }
    
    /// 刷新区域
    ///
    /// - Parameter component: <#component description#>
    private func reloadCitysComponent(_ contentView: WZActionSheetPickerView) {
        
        if type == .provinceCityArea {
            if self.dataSource?[provincesIndex].citys[citiesIndex].areas?.count ?? 0 > 0 {
                contentView.reloadComponent(2)
                contentView.selectRow(0, inComponent: 2, animated: true)
            }
        }
    }
    
    func prickerConfim(_ contentView: WZActionSheetPickerView) {
        contentView.dismiss()
        let provinceModel = (dataSource![provincesIndex].id,dataSource![provincesIndex].name)
        let citysModel = (dataSource![provincesIndex].citys[citiesIndex].id,dataSource![provincesIndex].citys[citiesIndex].name)
        
        switch type {
        case .provincesAndCities:
            confirmCallBack?(contentView, "\(provinceModel.1)-\(citysModel.1)")
        default:
            
            let areaModel = (dataSource![provincesIndex].citys[citiesIndex].areas?[areaIndex].id,dataSource![provincesIndex].citys[citiesIndex].areas?[areaIndex].name)
            if let areaString = areaModel.1 {
                confirmCallBack?(contentView, "\(provinceModel.1)-\(citysModel.1)-\(areaString)")
            } else {
                confirmCallBack?(contentView, "\(provinceModel.1)-\(citysModel.1)")
            }
        }
    }
    
    func prickerCancel(_ contentView: WZActionSheetPickerView) {
        contentView.dismiss()
        cancelCallBack?(contentView)
    }
}




/// MARK - 解析
public struct Result<T: Codable>: Codable {
    
    let code: Int
    let msg: String
    let data: T?
    
    
    enum CodingKeys: String, CodingKey {
        case code = "error_code"
        case msg = "msg"
        case data = "data"
    }
}


/// MARK - 省实体
public struct ProvinceModel: Codable {
    
    /// id
    let id: Int
    
    /// 名称
    let name: String
    
    /// 市区数组
    let citys: [CitysModel]
    
    enum CodingKeys: String, CodingKey {
        case id = "areaid"
        case name = "areaname"
        case citys = "citys"
    }
    
}

/// MARK - 市实体
public struct CitysModel: Codable {
    
    /// id
    let id: Int
    
    /// 名称
    let name: String
    
    /// 区
    let areas: [AreasModel]?
    
    enum CodingKeys: String, CodingKey {
        case id = "areaid"
        case name = "areaname"
        case areas = "areas"
    }
}

/// MARK - 区县实体
public struct AreasModel: Codable {
    
    /// id
    let id: Int
    
    /// 名称
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "areaid"
        case name = "areaname"
    }
}
