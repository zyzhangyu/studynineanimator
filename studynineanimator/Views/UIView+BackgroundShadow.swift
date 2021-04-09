//
//  UIView+BackgroundShadow.swift
//  studynineanimator
//
//  Created by developer on 2021/4/9.
//

import UIKit

@IBDesignable extension UIView {
    
    /* The color of the shadow.
     * Defaults to opaque black.
     * Colors created from patterns are currently NOT supported. Animatable.
     */
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor.init(cgColor: color)
            } else {
                return nil
            }
        }
    }
    
    /* The opacity of the shadow.
     * Defaults to 0. Specifying a value outside the [0,1] range will give undefined results.
     * Animatable.
     */
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize.init(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint.init(x: layer.shadowOffset.width, y: layer.shadowOffset.height)
        }
    }
    
    /* The blur radius used to create the shadow. Defaults to 3.
     * Animatable.
     */
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
}
