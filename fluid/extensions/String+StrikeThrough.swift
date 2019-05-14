//
//  String+StrikeThrough.swift
//  fluid
//
//  Created by Ziyad Khalil on 5/8/19.
//  Copyright © 2019 Ziyad Khalil. All rights reserved.
//
import UIKit
extension String{
    func strikeThrough()->NSAttributedString{
        let value = ".    "+self
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string:(value))
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "LamonyKamony")], range: NSMakeRange(0, 1))
        return attributeString
    }
}
