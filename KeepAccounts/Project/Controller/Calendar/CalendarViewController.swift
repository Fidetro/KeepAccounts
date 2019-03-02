//
//  CalendarViewController.swift
//  Calendar
//
//  Created by Fidetro on 21/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit
import SnapKit

fileprivate extension Selector {
    static let onLeftClick = #selector(CalendarViewController.onLeftClick(sender:))
    static let onRightClick = #selector(CalendarViewController.onRightClick(sender:))
    
}

class CalendarViewController: UIViewController,
ControllerProtocol {
    
    lazy var containerView: CalendarContainerView = {
        var containerView = CalendarContainerView()
        containerView.delegate = self
        return containerView
    }()
    
    lazy var spendView: SpendView = {
        var view = SpendView()
        return view
    }()
    
    var isScrollToBottom = false

    lazy var scrollView: UIScrollView = {
        var view = UIScrollView()
        view.contentSize = CGSize(width: 0, height: UIScreen.main.bounds.size.height*2)
        view.isPagingEnabled = true
        view.isScrollEnabled = false
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snpLayoutSubview()
        containerView.refreshEvent()
        setNavigationStyle()
        view.backgroundColor = .themeBackgroundColor()
    }
    
    
    @objc func onLeftClick(sender:UIBarButtonItem) {
        
        if isScrollToBottom == true {
            scrollView.setContentOffset(.zero, animated: true)
            navigationItem.setupNavigationItem(items: [UIImage.init(named: "nav_right")!],
                                               orientation: .right,
                                               actions: [.onRightClick],
                                               target: self)
            isScrollToBottom = false
        }else{
            DateHelper.shared.last()
            setNavigationStyle()
            containerView.refreshEvent()
        }
        
    }
    
    @objc func onRightClick(sender:UIBarButtonItem) {
        DateHelper.shared.next()
        setNavigationStyle()
        containerView.refreshEvent()
    }
    
    
    func refreshEvent() {
        
    }
    

    
    func setNavigationStyle() {
        navigationItem.setupNavigationItem(items: [UIImage.init(named: "nav_left")!],
                                           orientation: .left,
                                           actions: [.onLeftClick],
                                           target: self)
        navigationItem.setupNavigationItem(items: [UIImage.init(named: "nav_right")!],
                                           orientation: .right,
                                           actions: [.onRightClick],
                                           target: self)
        
        setTitle(DateHelper.shared.today.format(with: "yyyy-MM"), color: .white)
        setNavigationBar(color: .themeBlackColor())
    }
    
    func snpLayoutSubview() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        scrollView.addSubview(spendView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        containerView.snp.makeConstraints{
            $0.left.right.equalTo(view)
            $0.top.equalTo(scrollView)
            $0.height.equalTo(UIScreen.main.bounds.size.height)
        }
        spendView.snp.makeConstraints{
            $0.top.equalTo(containerView.snp.bottom)
            $0.left.right.equalTo(view)
            $0.height.equalTo(UIScreen.main.bounds.size.height)
        }
    }
}

extension CalendarViewController:CalendarContainerViewProtocol,
UIScrollViewDelegate {
    
    func didSelectDates(_ dates: [Date]) {
        navigationItem.setupNavigationItem(items: nil,
                                           orientation: .right,
                                           actions: [.onRightClick],
                                           target: self)
        isScrollToBottom = true
        scrollView.setContentOffset(CGPoint(x: 0, y: UIScreen.main.bounds.size.height), animated: true)
        scrollView.isPagingEnabled = true
        let expends = Expend.select(where: "date >= ? and date <= ?", values: [dates[0],dates[1]], orderBy: "date", orderByType: .asc) as? [Expend]
        spendView.updateExpends(expends)
    }
    
}
