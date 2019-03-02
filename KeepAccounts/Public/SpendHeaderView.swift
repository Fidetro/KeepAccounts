//
//  SpendHeaderView.swift
//  KeepAccounts
//
//  Created by Fidetro on 2019/2/25.
//  Copyright © 2019 karim. All rights reserved.
//

import UIKit

class SpendHeaderView: UITableViewHeaderFooterView {

    lazy var sumLabel: UILabel = {
        var label = UILabel()
        label.font = .themeFont(ofSize: 50)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    static func height() -> CGFloat {
        return 200
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: SpendHeaderView.identifier())
        snpLayoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateSum(_ sum:Double) {
        sumLabel.text = String.init(format: "%.2f", sum)
    }
    
    func snpLayoutSubview() {
        contentView.addSubview(sumLabel)
        sumLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
}
