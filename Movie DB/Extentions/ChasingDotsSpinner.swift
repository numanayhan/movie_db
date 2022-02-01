//
//  ChasingDotsSpinner.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import Foundation
import UIKit

@IBDesignable
public class ChasingDotsSpinner: Spinner {
    private var leftCircleLayer = CAShapeLayer()
       private var rightCircleLayer = CAShapeLayer()
       
       override public func didMoveToWindow() {
           super.didMoveToWindow()
           
           layer.addSublayer(rightCircleLayer)
           layer.addSublayer(leftCircleLayer)
       }
       
       override public func draw(_ rect: CGRect) {
           super.draw(rect)
           leftCircleLayer.fillColor = isTranslucent ? primaryColor.cgColor : UIColor.white.cgColor
           rightCircleLayer.fillColor = isTranslucent ? primaryColor.cgColor : UIColor.white.cgColor
       }
       
       override public func layoutSubviews() {
           super.layoutSubviews()
           
           let circleSize = CGSize(width: contentSize.width / 2, height: contentSize.height / 2)
           leftCircleLayer.frame = CGRect(origin: contentOrigin,
                                          size: circleSize)
           leftCircleLayer.path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: circleSize)).cgPath
           
           rightCircleLayer.frame = CGRect(origin: contentOrigin,
                                           size: circleSize)
           rightCircleLayer.path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: circleSize)).cgPath
       }
       
       override public func startLoading() {
           super.startLoading()

           let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
           scaleAnimation.fromValue = 0
           scaleAnimation.toValue = 1
           scaleAnimation.repeatCount = .infinity
           scaleAnimation.duration = 1.1 / animationSpeed
           scaleAnimation.fillMode = .backwards
           scaleAnimation.autoreverses = true
           scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
           
           let positionAnimation = CAKeyframeAnimation(keyPath: "position")
           positionAnimation.path = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: contentSize.width / 4 + leftCircleLayer.frame.size.width / 16 + contentOrigin.x,
                                                                                y: contentSize.height / 4 + leftCircleLayer.frame.size.height / 16 + contentOrigin.y),
                                                                size: CGSize(width: contentSize.width / 2, height: contentSize.height / 2))).cgPath
           positionAnimation.repeatCount = .infinity
           positionAnimation.fillMode = .backwards
           positionAnimation.duration = 2 / animationSpeed
           positionAnimation.calculationMode = .paced
           
           leftCircleLayer.add(positionAnimation, forKey: nil)
           leftCircleLayer.add(scaleAnimation, forKey: nil)
           
           positionAnimation.beginTime = CACurrentMediaTime() + 0.3
           scaleAnimation.toValue = CATransform3DScale(CATransform3DIdentity, 0, 0, 1)
           scaleAnimation.fromValue = CATransform3DIdentity
           
           rightCircleLayer.add(positionAnimation, forKey: nil)
           rightCircleLayer.add(scaleAnimation, forKey: nil)
       }
}
/**
 Spinner protocol that exposes its interface
 */
public protocol SpinnerType: AnyObject {
    /// Starts the spinner animation
    func startLoading()
    
    /// Primary color of the spinner
    var primaryColor: UIColor { get set }
    
    /// Flag that indicates if the view is opaque or translucent. It modifies the way in which the primary color is applied.
    var isTranslucent: Bool { get set }
    
    /// Insets of the spinner
    var contentInsets: UIEdgeInsets { get set }
    
    /// Speed of the animation
    var animationSpeed: Double { get set }
}

/**
 Spinner base class. It's a view that exposes the spinner type interface
*/
@IBDesignable
public class Spinner: UIView, SpinnerType {
    
    @IBInspectable public var primaryColor: UIColor = UIColor.darkBlue { didSet { setNeedsDisplay() } }
    
    @IBInspectable public var isTranslucent: Bool = true { didSet { setNeedsDisplay() } }
    
    @IBInspectable public var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) { didSet { setNeedsLayout() } }
    
    public var animationSpeed: Double = 1
    
    var contentSize: CGSize {
        let size = min(bounds.width - (contentInsets.left + contentInsets.right),
                       bounds.height - (contentInsets.top + contentInsets.bottom))
        return CGSize(width: size,
                      height: size)
    }
    
    var contentOrigin: CGPoint {
        return CGPoint(x: (bounds.width - contentSize.width) / 2,
                       y: (bounds.height - contentSize.height) / 2)
    }
    
    var contentRect: CGRect {
        return CGRect(origin: contentOrigin, size: contentSize)
    }
    
    var contentBounds: CGRect {
        return CGRect(origin: .zero, size: contentSize)
    }
    
    /**
     Initializes a new Spinner.
     
     - Parameter primaryColor:      Primary color of the spinner
    */
    public convenience init(primaryColor: UIColor) {
        self.init(primaryColor: primaryColor,
                  frame: .zero)
        self.primaryColor = primaryColor
    }
    
    /**
     Initializes a new Spinner.
     
     - Parameter primaryColor:      Primary color of the spinner
     - Parameter frame:             Frame of the view
     */
    public convenience init(primaryColor: UIColor, frame: CGRect) {
        self.init(frame: frame)
        self.primaryColor = primaryColor
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if isTranslucent {
            isOpaque = !isTranslucent
        } else {
            primaryColor.setFill()
            UIRectFill(rect)
        }
    }
    
    public func startLoading() {
        layoutIfNeeded()
    }
    
}

/**
 Extended spinner. It uses two different colors.
 */
public class DoubleColorSpinner: Spinner {
    
    /// Secondary color of the spinner
    public var secondaryColor: UIColor = UIColor.lightBlue { didSet { setNeedsDisplay() } }

    /**
     Initializes a new extended Spinner.
     
     - Parameter primaryColor:      Primary color of the spinner
     - Parameter secondaryColor:    Secondary color of the spinner
     - Parameter frame:             Frame of the view
     */
    public convenience init(primaryColor: UIColor, secondaryColor: UIColor) {
        self.init(primaryColor: primaryColor,
                  secondaryColor: secondaryColor,
                  frame: .zero)
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
    
    /**
     Initializes a new extended Spinner.
     
     - Parameter primaryColor:      Primary color of the spinner
     - Parameter secondaryColor:    Secondary color of the spinner
     - Parameter frame:             Frame of the view
     */
    public convenience init(primaryColor: UIColor, secondaryColor: UIColor, frame: CGRect) {
        self.init(frame: frame)
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
}

extension UIColor {
    static var lightBlue: UIColor { return UIColor(red: 100 / 255, green: 181 / 255, blue: 246 / 255, alpha: 1) }
    static var darkBlue: UIColor { return UIColor(red: 30 / 255, green: 136 / 255, blue: 229 / 255, alpha: 1) }
}
