//
//  TodayViewController.swift
//  KeepAccounts
//
//  Created by Fidetro on 2019/2/25.
//  Copyright © 2019 karim. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let onLeftClick = #selector(TodayViewController.onLeftClick(sender:))
    static let onRightClick = #selector(TodayViewController.onRightClick(sender:))
    
}

class TodayViewController: UIViewController,ControllerProtocol {

    var startDate = Date().zero()
    
    lazy var spendView: SpendView = {
        var view = SpendView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.themeBackgroundColor()
        
        snpLayoutSubview()
        setNavigationStyle()
        refreshEvent()
    }
    
    func refreshEvent() {
        let endDate = Date.init(timeIntervalSince1970: startDate.timeIntervalSince1970+24*60*60)
        if let expends = Expend.select(where: "date >= ? and date <= ?", values: [startDate,endDate], orderBy: "date", orderByType: .asc) as? [Expend] {
            spendView.updateExpends(expends)
        }
    }
    
}

// MARK: setup view
extension TodayViewController {
    
    @objc func onLeftClick(sender:UIButton) {
        startDate = Date(timeIntervalSince1970: startDate.timeIntervalSince1970-24*60*60)
        setTitle(startDate.format(with: "yyyy-MM-dd"), color: .white)
        refreshEvent()
    }
    
    @objc func onRightClick(sender:UIButton) {
        startDate = Date(timeIntervalSince1970: startDate.timeIntervalSince1970+24*60*60)
        setTitle(startDate.format(with: "yyyy-MM-dd"), color: .white)
        refreshEvent()
    }
    
    func snpLayoutSubview() {
        view.addSubview(spendView)
        spendView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setNavigationStyle() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        setTitle(formatter.string(from: startDate), color: .white)
        navigationItem.setupNavigationItem(items: [UIImage.init(named: "nav_left")!],
                                           orientation: .left,
                                           actions: [.onLeftClick],
                                           target: self)
        navigationItem.setupNavigationItem(items: [UIImage.init(named: "nav_right")!],
                                           orientation: .right,
                                           actions: [.onRightClick],
                                           target: self)
        
        setNavigationBar(color: .themeBlackColor())
    }
    
}

// MARK: view delegate
extension TodayViewController {
    
}
