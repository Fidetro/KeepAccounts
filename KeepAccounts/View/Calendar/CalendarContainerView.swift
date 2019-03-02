//
//  CalendarContainerView.swift
//  Calendar
//
//  Created by Fidetro on 21/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit

protocol CalendarContainerViewProtocol:class {
    func didSelectDates(_ dates: [Date])
}




class CalendarContainerView:UIView {
    
    weak var delegate : CalendarContainerViewProtocol?
    
    var selectDates = [Date]()
    /// 日期
    var days = [Int]()
    /// 记录点击的section
    var selectedIndexPath = IndexPath.init(row: 0, section: 0)
    
    var clickQuick_block : ((_ row : Int)->())? = nil
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        
      
        var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout:flowLayout)
        addSubview(collectionView)
        collectionView.backgroundColor = .themeBackgroundColor()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EmptyCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: EmptyCollectionReusableView.identifier)
        collectionView.register(QuickUploadCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: QuickUploadCollectionReusableView.identifier)
        collectionView.register(CalendarIntroductionCollectionViewCell.self,
                                forCellWithReuseIdentifier: CalendarIntroductionCollectionViewCell.identifier)
        collectionView.register(CalendarWeekCollectionViewCell.self,
                                forCellWithReuseIdentifier: CalendarWeekCollectionViewCell.identifier)
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        snpLayoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshEvent() {
        days = [Int]()
        let emptyCount = DateHelper.shared.firstDayForCurrentMonth.weekDay() - 1
        for _ in 0..<emptyCount {
            days.append(0)
        }
        for i in 0..<DateHelper.shared.firstDayForCurrentMonth.MaxDayOfMonth() {
                days.append(i+1)
        }
        collectionView.reloadData()
    }
    
    /// collectionView之间的间隔
    ///
    /// - Returns: 间隔距离
    func space() -> CGFloat {
        return 1
    }
    
    func snpLayoutSubview() {
        collectionView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }


    }
    
}

extension CalendarContainerView:UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard section != 0 else {
            return 7
        }
        
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = CalendarWeekCollectionViewCell
                .dequeueReusable(withCollectionView: collectionView, for: indexPath)
            cell.updateWeek(row:indexPath.row)
            
            return cell
        default:
            let cell = CalendarIntroductionCollectionViewCell
                .dequeueReusable(withCollectionView: collectionView, for: indexPath)
            let day = days[indexPath.row]
            var selected = false
            for selectDate in selectDates {
               let date = Date.getDateWith(year: DateHelper.shared.today.year(), month: DateHelper.shared.today.month(), day: day)
                if selectDate == date {
                    selected = true
                    break
                }
            }
            cell.updateDay(day, selected: selected)
            
            return cell
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = days[indexPath.row]
        if day != 0 {
            
            let today = DateHelper.shared.today
            let date = Date.getDateWith(year: today.year(), month: today.month(), day: day)
            selectDates.append(date)
            selectDates.sort(by: {$0<$1})
            if selectDates.count == 2 {
                delegate?.didSelectDates(selectDates)
               selectDates.removeAll()
            }
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width/7-space()
        if indexPath.section != 0 {
            
        }
        return CGSize.init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if section == 0 {
            return CGSize.init(width: collectionView.bounds.width, height: CGFloat.leastNormalMagnitude)
        }
                
        return CGSize.init(width: collectionView.bounds.width, height: CGFloat.leastNormalMagnitude)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
