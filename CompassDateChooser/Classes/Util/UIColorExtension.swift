//
//  UIColorExtension.swift
//  CompassDateChooser_Example
//
//  Created by compass on 2020/6/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

extension UIColor {
    public func getPureColorImage(size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        let getContext = UIGraphicsGetCurrentContext()
        guard let context = getContext else { return nil }
        context.setFillColor(self.cgColor)
        context.addRect(CGRect.init(origin: CGPoint.zero, size: size))
        context.fillPath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
