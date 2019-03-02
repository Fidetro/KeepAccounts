//
//  CalendarIntroductionCollectionViewCell.swift
//  Calendar
//
//  Created by Fidetro on 21/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit

class CalendarIntroductionCollectionViewCell: UICollectionViewCell {
    static let identifier = "kCalendarIntroductionCollectionViewCellIdentifier"
    
    lazy var selectView: UIView = {
        var view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .white
        titleLabel.font = .themeFont(ofSize: 17)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .themeBlackColor()
        snpLayoutSubview()

    }
  
    
    static func dequeueReusable(withCollectionView collectionView:UICollectionView,for indexPath:IndexPath) -> CalendarIntroductionCollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: CalendarIntroductionCollectionViewCell.identifier, for: indexPath) as! CalendarIntroductionCollectionViewCell
    }
  

    
    func updateDay(_ day: Int,selected: Bool) {
        titleLabel.text =  day == 0 ? "" : "\(day)"
        selectView.isHidden = !selected
        
    }
    
    
    
    func snpLayoutSubview() {
        selectView.layer.masksToBounds = true
        selectView.layer.cornerRadius = bounds.size.height / 2
        contentView.addSubview(selectView)
        contentView.addSubview(titleLabel)
        selectView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
