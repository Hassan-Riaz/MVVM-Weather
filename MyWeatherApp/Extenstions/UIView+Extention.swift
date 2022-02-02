//
//  UIView+Extention.swift
//  MyWeatherApp
//
//  Created by Munsif Hayat on 01/02/2022.
//

import UIKit
import Foundation

class RoundImageView: UIImageView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.height / 2
        layer.masksToBounds = true
    }
}

class RoundView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.height / 2
        layer.masksToBounds = true
    }
}


class RoundButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.height / 2
        layer.masksToBounds = true
    }
}

extension UIView {
    func shake(duration: TimeInterval = 0.3, shakeCount: Float = 6, xValue: CGFloat = 12, yValue: CGFloat = 0){
        self.transform = CGAffineTransform(translationX: xValue, y: yValue)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    /* SHADOW */
    @IBInspectable var shadowColor:UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
    
    @IBInspectable var shadowOpacity:Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
            
        }
    }
    
    @IBInspectable var shadowOffset:CGSize {
        set {
            layer.shadowOffset = newValue
        }
        get {
            return layer.shadowOffset
        }
    }
    @IBInspectable var shadowRadius:CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    func addshadow(top: Bool,
                   left: Bool,
                   bottom: Bool,
                   right: Bool,
                   shadowRadius: CGFloat = 2.0) {
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 1.0
        
        let path = UIBezierPath()
        var x: CGFloat = 0
        var y: CGFloat = 0
        var viewWidth = self.frame.width
        var viewHeight = self.frame.height
        
        // here x, y, viewWidth, and viewHeight can be changed in
        // order to play around with the shadow paths.
        if (!top) {
            y+=(shadowRadius+1)
        }
        if (!bottom) {
            viewHeight-=(shadowRadius+1)
        }
        if (!left) {
            x+=(shadowRadius+1)
        }
        if (!right) {
            viewWidth-=(shadowRadius+1)
        }
        // selecting top most point
        path.move(to: CGPoint(x: x, y: y))
        // Move to the Bottom Left Corner, this will cover left edges
        /*
         |☐
         */
        path.addLine(to: CGPoint(x: x, y: viewHeight))
        // Move to the Bottom Right Corner, this will cover bottom edge
        /*
         ☐
         -
         */
        path.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
        // Move to the Top Right Corner, this will cover right edge
        /*
         ☐|
         */
        path.addLine(to: CGPoint(x: viewWidth, y: y))
        // Move back to the initial point, this will cover the top edge
        /*
         _
         ☐
         */
        path.close()
        self.layer.shadowPath = path.cgPath
    }
    
    func roundView() {
        layer.cornerRadius = self.frame.height / 2
        layer.masksToBounds = true
    }
    
    func CurveCorner(radius:Float) -> Void {
        layer.cornerRadius = CGFloat(radius)
        layer.masksToBounds = true
    }
    
    func borderView() -> Void {
        layer.borderWidth = 1
        layer.borderColor = UIColor(red:240/255, green:240/255, blue:240/255, alpha: 1).cgColor
    }
    
    
}

extension UIView {
    // OUTPUT 2
    func dropShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 6
        
    }
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.frame.size.width/2 - 125, y: self.frame.size.height-130, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}



/**
 The internal subclass for CAShapeLayer.
 This is the class that handles all the drawing and animation.
 This class is not interacted with, instead
 properties are set in UICircularRing

 */
class UICircularRingLayer: CAShapeLayer {

    // MARK: Properties
    @NSManaged var val: CGFloat

    let ringWidth: CGFloat = 20
    let startAngle = CGFloat(-90)

    // MARK: Init

    override init() {
        super.init()
    }

    override init(layer: Any) {
        guard let layer = layer as? UICircularRingLayer else { fatalError("unable to copy layer") }

        super.init(layer: layer)
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    // MARK: Draw

    /**
     Override for custom drawing.
     Draws the ring
     */
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        UIGraphicsPushContext(ctx)
        // Draw the rings
        drawRing(in: ctx)
        UIGraphicsPopContext()
    }

    // MARK: Animation methods

    /**
     Watches for changes in the val property, and setNeedsDisplay accordingly
     */
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == "val" {
            return true
        } else {
            return super.needsDisplay(forKey: key)
        }
    }

    /**
     Creates animation when val property is changed
     */
    override func action(forKey event: String) -> CAAction? {
        if event == "val"{
            let animation = CABasicAnimation(keyPath: "val")
            animation.fromValue = presentation()?.value(forKey: "val")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            animation.duration = 2
            return animation
        } else {
            return super.action(forKey: event)
        }
    }


    /**
     Draws the ring for the view.
     Sets path properties according to how the user has decided to customize the view.
     */
    private func drawRing(in ctx: CGContext) {

        let center: CGPoint = CGPoint(x: bounds.midX, y: bounds.midY)

        let radiusIn: CGFloat = (min(bounds.width, bounds.height) - ringWidth)/2
        // Start drawing
        let innerPath: UIBezierPath = UIBezierPath(arcCenter: center,
                                                   radius: radiusIn,
                                                   startAngle: startAngle,
                                                   endAngle: toEndAngle,
                                                   clockwise: true)

        // Draw path
        ctx.setLineWidth(ringWidth)
        ctx.setLineJoin(.round)
        ctx.setLineCap(CGLineCap.round)
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.addPath(innerPath.cgPath)
        ctx.drawPath(using: .stroke)

    }


    var toEndAngle: CGFloat {
        return (val * 360.0) + startAngle
    }


}

extension CGFloat {
    var rads: CGFloat { return self * CGFloat.pi / 180 }
}

@IBDesignable open class UICircularRing: UIView {

    /**
     Set the ring layer to the default layer, casted as custom layer
     */
    var ringLayer: UICircularRingLayer {
        return layer as! UICircularRingLayer
    }

    /**
     Overrides the default layer with the custom UICircularRingLayer class
     */
    override open class var layerClass: AnyClass {
        return UICircularRingLayer.self
    }

    /**
     Override public init to setup() the layer and view
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        // Call the internal initializer
        setup()
    }

    /**
     Override public init to setup() the layer and view
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Call the internal initializer
        setup()
    }

    /**
     This method initializes the custom CALayer to the default values
     */
    func setup(){
        // Helps with pixelation and blurriness on retina devices
        ringLayer.contentsScale = UIScreen.main.scale
        ringLayer.shouldRasterize = true
        ringLayer.rasterizationScale = UIScreen.main.scale * 2
        ringLayer.masksToBounds = false

        backgroundColor = UIColor.clear
        ringLayer.backgroundColor = UIColor.clear.cgColor
        ringLayer.val = 0
    }


    func startAnimation() {
        ringLayer.val = 1
    }
}

