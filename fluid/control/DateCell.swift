//
//  DateCell.swift
//  fluid
//
//  Created by Ziyad Khalil on 5/9/19.
//  Copyright © 2019 Ziyad Khalil. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DateCell: JTAppleCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    func markSelected(){
        let radius = bgView.bounds.height / 2
        bgView.layer.cornerRadius = radius
        bgView.clipsToBounds = true
        
        dateLabel.textColor = UIColor.black
        bgView.backgroundColor = UIColor.white
    }
   
    func markDeselected(){
        dateLabel.textColor = UIColor.white
        bgView.backgroundColor = UIColor.black
        
    }
}
