//
//  SpendTableViewCell.swift
//  KeepAccounts
//
//  Created by Fidetro on 2019/2/25.
//  Copyright © 2019 karim. All rights reserved.
//

import UIKit

class SpendTableViewCell: UITableViewCell {
    
    lazy var bannerLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        return label
    }()
    
    lazy var sumLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        snpLayoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: setup view
extension SpendTableViewCell {
    
    func update(_ expend:Expend) {
        if let comment = expend.comment,comment.count > 0 {
            bannerLabel.text = comment
        }else if let type = expend.type{
            bannerLabel.text = AccountType(rawValue: type)?.desc()
        }
        sumLabel.text = String.init(format: "%.2lf", expend.sum ?? 0)
    }
    
    func snpLayoutSubview() {
        contentView.addSubview(bannerLabel)
        contentView.addSubview(sumLabel)
        bannerLabel.snp.makeConstraints{
            $0.left.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        sumLabel.snp.makeConstraints{
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
    }
}
