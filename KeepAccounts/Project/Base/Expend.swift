//
//  Expend.swift
//  KeepAccounts
//
//  Created by Fidetro on 2019/2/21.
//  Copyright © 2019 karim. All rights reserved.
//

import UIKit
import SwiftFFDB
enum AccountType:Int,CaseIterable {
    case breakfast
    case lunch
    case dinner
    case shop
    case drink
    case trip
    
    func desc() -> String {
        switch self {
        case .breakfast:
            return "早餐"
        case .lunch:
            return "午饭"
        case .dinner:
            return "晚饭"
        case .shop:
            return "购物"
        case .drink:
            return "饮料"
        case .trip:
            return "出行"
        }
    }
    
    func enDesc() -> String {
        switch self {
        case .breakfast:
            return "breakfast"
        case .lunch:
            return "lunch"
        case .dinner:
            return "dinner"
        case .shop:
            return "shop"
        case .drink:
            return "drink"
        case .trip:
            return "trip"
        }
        
    }
    
}

class Expend: FFObject {
    
    var primaryID: Int64?
    var type: AccountType.RawValue?
    var sum : Double?
    var date : Date?
    var comment : String?
    
    required init() {
        
    }
    
    static func primaryKeyColumn() -> String {
        return "primaryID"
    }
    
    static func memoryPropertys() -> [String]? {
        return nil
    }
    
    static func customColumnsType() -> [String : String]? {
        return nil
    }
    
    static func customColumns() -> [String : String]? {
        return nil
    }
}
