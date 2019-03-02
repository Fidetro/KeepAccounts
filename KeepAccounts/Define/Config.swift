//
//  Config.swift
//  KeepAccounts
//
//  Created by Fidetro on 2019/2/24.
//  Copyright © 2019 karim. All rights reserved.
//

import UIKit

extension UIColor {
    static func themeBackgroundColor() -> UIColor {
        return UIColor.init(rgb: 0xf88542)
    }
    
    static func themeBlackColor() -> UIColor {
        return UIColor.init(rgb: 0xf88542)
    }
    static func placeholderColor() -> UIColor {
        return UIColor.init(rgb: 0xD8D8D8)
    }
}



extension UIFont {
    static func themeFont(ofSize: CGFloat) -> UIFont {
        guard let font = UIFont.init(name: "PingFangSC-Regular", size: ofSize) else {
            return UIFont.systemFont(ofSize:ofSize)
        }
        return font
    }
}
