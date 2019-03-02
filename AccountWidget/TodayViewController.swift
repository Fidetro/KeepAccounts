//
//  TodayViewController.swift
//  AccountWidget
//
//  Created by Fidetro on 2019/2/21.
//  Copyright © 2019 karim. All rights reserved.
//

import UIKit
import NotificationCenter
import SwiftFFDB
class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var accountField: UITextField!
    
    @IBOutlet weak var typeButton: UIButton!
    
    var typeIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let groupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.karim.keepaccount") as? NSURL {
            let path = groupURL.path! + "/" + "KeepAccount.sqlite"
            FMDBConnection.databasePath = path
        }
        Expend.registerTable()
        
//        guard let expends = Expend.select() as? [Expend] else { return  }
//
//        for expend in expends {
//            print(expend.type)
//            print(expend.sum)
//            print(expend.date)
//        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let account = UIPasteboard.general.string,let value = Double(account) {
            accountField.text = account
        }
    }
        
    @IBAction func clickTypeAction(_ sender: Any) {
        typeIndex += 1
        
        if typeIndex > (AccountType.allCases.count - 1) {
            typeIndex = AccountType.breakfast.rawValue
        }
        
        if let type = AccountType(rawValue: typeIndex) {
            typeButton.setTitle(type.enDesc(), for: .normal)
        }
        
        
    }
    @IBAction func confirmAction(_ sender: Any) {
        if let account = accountField.text,let value = Double(account) {
            let expend = Expend()
            expend.type = typeIndex
            expend.date = Date()
            expend.sum = value
            expend.insert()
            accountField.text = nil
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
