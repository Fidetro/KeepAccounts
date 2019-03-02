//
//  AddBillViewController.swift
//  KeepAccounts
//
//  Created by Fidetro on 2019/2/23.
//  Copyright © 2019 karim. All rights reserved.
//

import UIKit
import SnapKit
class AddBillViewController: UIViewController {

    lazy var datePickerBtn: DatePickerButton = {
        var button = DatePickerButton()
        button.datePicker.datePickerMode = .dateAndTime
        button.setTitle("选择时间", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(selectTimeAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var typeBtn: PickerViewButton = {
        var descCollection = AccountType.allCases.map{ $0.desc() }
        var button = PickerViewButton.init(dataSource: [AccountType.allCases], detailSource: [descCollection])
        button.setTitle("选择类型", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(selectTypeAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var accountField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "金额"
        textField.textColor = .black
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var commentField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "备注"
        textField.textColor = .black
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var confirmBtn: UIButton = {
        var button = UIButton()
        button.setTitle("提交", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(confirmAction(_:)), for: .touchUpInside)
        return button
    }()
    
    var selectType : AccountType?
    var selectDate : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        snapLayoutSubview()
    }
    
    @objc func selectTimeAction(_ sender: DatePickerButton) {
        sender.becomeFirstResponder()
        sender.selectDate = { [weak self,weak sender] (date) in
            sender?.resignFirstResponder()
            sender?.setTitle(date.format(with: "YYYY-MM-dd HH:mm"), for: .normal)
            self?.selectDate = date
        }
    }
    
    @objc func selectTypeAction(_ sender: PickerViewButton) {
        sender.becomeFirstResponder()
        sender.selectRow = { [weak self,weak sender] (dataSource,detailSource) in
            if let type = dataSource[0] as? AccountType {
                self?.selectType = type
            }
            sender?.setTitle(detailSource[0], for: .normal)
        }
    }
    
    
    @objc func confirmAction(_ sender: UIButton) {
        
        guard let sum = Double(accountField.text ?? "-"),
            let selectDate = selectDate,
            let selectType = selectType else { return  }
        
        let expend = Expend()
        expend.sum = sum
        expend.date = selectDate
        expend.type = selectType.rawValue
        expend.comment = commentField.text
        expend.insert()
        
        self.selectDate = nil
        self.selectType = nil
        
        accountField.text = nil
        commentField.text = nil
        datePickerBtn.setTitle("选择时间", for: .normal)
        typeBtn.setTitle("选择类型", for: .normal)
    }
}

// MARK: setup view
extension AddBillViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func snapLayoutSubview() {
        
        view.addSubview(typeBtn)
        view.addSubview(datePickerBtn)
        view.addSubview(accountField)
        view.addSubview(commentField)
        view.addSubview(confirmBtn)
        
        typeBtn.snp.makeConstraints{
            $0.top.equalTo(navigationHeight()+20.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(40)
        }
        datePickerBtn.snp.makeConstraints{
            $0.top.equalTo(typeBtn.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(40)
        }
        accountField.snp.makeConstraints{
            $0.top.equalTo(datePickerBtn.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(40)
        }
        commentField.snp.makeConstraints{
            $0.top.equalTo(accountField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(40)
        }
        confirmBtn.snp.makeConstraints{
            $0.top.equalTo(commentField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(40)
        }
        
    }
}

// MARK: view delegate
extension AddBillViewController {
    
}
