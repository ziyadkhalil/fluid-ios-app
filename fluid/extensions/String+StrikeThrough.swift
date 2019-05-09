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
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
