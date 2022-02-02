//
//  ConstraintHelper.swift
//  FetchAndParseXML
//
//  Created by Shashank Pali on 02/02/22.
//

import Foundation
import UIKit

struct ConstraintHelper {
    
    enum Center {
    case horizontally
    case vertically
    }
    
    static func make(view: UIView, center: Center, toView: UIView) {
        let attribute: NSLayoutConstraint.Attribute = center == Center.horizontally ? .centerX : .centerY
        NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: toView, attribute: attribute, multiplier: 1, constant: 0).isActive = true
    }
    
    static func set(view: UIView, widthRatio: CGFloat, respectToView: UIView) {
        NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: respectToView, attribute: .width, multiplier: widthRatio, constant: 0).isActive = true
    }
    
    static func place(view: UIView, belowView: UIView, distance: CGFloat) {
        NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: belowView, attribute: .bottom, multiplier: 1, constant: distance).isActive = true
    }
}
