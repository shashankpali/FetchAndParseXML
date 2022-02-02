//
//  UIView+Extension.swift
//  FetchAndParseXML
//
//  Created by Shashank Pali on 02/02/22.
//

import UIKit

extension UIView {
    enum Center {
    case horizontally
    case vertically
    }
    
    func make(center: Center, toView: UIView) {
        let attribute: NSLayoutConstraint.Attribute = center == Center.horizontally ? .centerX : .centerY
        NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: toView, attribute: attribute, multiplier: 1, constant: 0).isActive = true
    }
    
    func set(widthRatio: CGFloat, respectToView: UIView) {
        NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: respectToView, attribute: .width, multiplier: widthRatio, constant: 0).isActive = true
    }
    
    func place(belowView: UIView, distance: CGFloat) {
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: belowView, attribute: .bottom, multiplier: 1, constant: distance).isActive = true
    }
    
    func place(aboveView: UIView, distance: CGFloat) {
        NSLayoutConstraint(item: aboveView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: distance).isActive = true
    }
}
