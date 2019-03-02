//
//  SpendView.swift
//  KeepAccounts
//
//  Created by Fidetro on 2019/2/25.
//  Copyright © 2019 karim. All rights reserved.
//

import UIKit

class SpendView: UIView,
UITableViewDelegate,
UITableViewDataSource {

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var expends = [Expend]()
    private var sum = Double(0)
    init() {
        super.init(frame: .zero)
        snpLayoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateExpends(_ expends: [Expend]?) {
        sum = 0
        guard let expends = expends else {
            self.expends = [Expend]()
            tableView.reloadData()
            return
        }
        self.expends = expends
        for expend in expends {
            sum += expend.sum ?? 0
        }
        tableView.reloadData()
    }
    
    func snpLayoutSubview() {
        addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

extension SpendView {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusable(withClass: SpendTableViewCell.self)
        cell.update(expends[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusable(withClass: SpendHeaderView.self)
        headerView.updateSum(sum)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SpendHeaderView.height()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
}
