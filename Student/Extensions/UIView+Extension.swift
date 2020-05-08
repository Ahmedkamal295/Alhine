//
//  4.swift
//  TYOUT
//
//  Created by Ali Hamed on 9/25/18.
//  Copyright © 2018 Gra7. All rights reserved.
//

import UIKit
import JHSpinner
typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    
    var startPoint : CGPoint {
        return points.startPoint
    }
    
    var endPoint : CGPoint {
        return points.endPoint
    }
    
    var points : GradientPoints {
        switch self {
        case .topRightBottomLeft:
            return (CGPoint(x: 0.0,y: 1.0), CGPoint(x: 1.0,y: 0.0))
        case .topLeftBottomRight:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 1,y: 1))
        case .horizontal:
            return (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5))
        case .vertical:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 0.0,y: 1.0))
        }
    }
}


extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
  
  
    @IBInspectable var shadowOffset: CGSize{
        get{
            return self.layer.shadowOffset
        }
        set{
            self.layer.shadowOffset = newValue
        }
    }
    func applyGradient(withColours colours: [UIColor], locations: [NSNumber]? = nil) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradient(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
    @IBInspectable var shadowColor: UIColor{
        get{
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set{
            self.layer.shadowColor = newValue.cgColor
        }
    }
    func removeNoDataLabel(tag: Int = 10000){
        if let noDataLabel = self.viewWithTag(tag) {
            UIView.animate(withDuration: 0.2, animations: {
                noDataLabel.alpha = 0.0
            }) { finished in
                noDataLabel.removeFromSuperview()
            }
        }
    }
    func setNoDataLabel(text: String, frameRect: CGRect = CGRect.zero, withBackgroundColor backgroundColor: UIColor =  #colorLiteral(red: 0.1593917012, green: 0.7106058002, blue: 1, alpha: 0), textColor: UIColor = UIColor.black ){
        let containerView = UIView()
        let label = UILabel()
        let image = UIImageView()
        
        if frameRect == CGRect.zero{
            containerView.frame = bounds
        }
        else{
            containerView.frame = frameRect
        }
        containerView.tag = 10000
        containerView.backgroundColor = #colorLiteral(red: 0.07960281521, green: 0.1419835687, blue: 0.3420339823, alpha: 0)
        
        label.frame = containerView.bounds
        label.frame.size.width =  containerView.frame.size.width
        label.numberOfLines = 0
        label.backgroundColor = self.backgroundColor
        label.textAlignment = .center
        label.textColor = textColor
        label.text = ""
        image.image = #imageLiteral(resourceName: "language-1")
        image.frame = containerView.bounds
        image.frame.size.width =  80
        image.frame.size.height =  80
        image.center = containerView.center
        image.backgroundColor = #colorLiteral(red: 0.1593917012, green: 0.7106058002, blue: 1, alpha: 0)
        containerView.addSubview(label)
        containerView.addSubview(image)
        addSubview(containerView)
    }
    
    func lock(frameRect: CGRect = CGRect.zero) {
        if (viewWithTag(10) != nil) {
            //View is already locked
        }
        else {
            let lockView = UIView()
            
            if frameRect == CGRect.zero{
                lockView.frame = bounds
            }
            else{
                lockView.frame = frameRect
            }
            
            lockView.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
            
            lockView.tag = 10
            lockView.alpha = 0.0
            
            
            
            //            let activityIndicator = UIActivityIndicatorView(frame:CGRectMake(lockView.center.x,lockView.center.y, 50, 50))
            //
            //            activityIndicator.style = .whiteLarge
            //            activityIndicator.center.x = lockView.center.x
            //            activityIndicator.center.y = lockView.center.y
            //            activityIndicator.color = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
            //
            
            //            activityIndicator.startAnimating()
            let myString = ""
            let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.clear ]
            let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
            let spinner = JHSpinnerView.showOnView(self, spinnerColor: #colorLiteral(red: 0.984234035, green: 0.9925152659, blue: 0.9952742457, alpha: 1), overlay:.circular, overlayColor: #colorLiteral(red: 0.2967801094, green: 0.7321691513, blue: 0.8268392086, alpha: 1).withAlphaComponent(0.8)
                , attributedText: myAttrString)
            lockView.addSubview(spinner)
            addSubview(lockView)
            
            UIView.animate(withDuration: 0.2) {
                lockView.alpha = 1.0
            }
        }
    }
    //    func spinnerStart(){
    //        let spinner = JHSpinnerView.showOnView(self.view, spinnerColor:UIColor.red, overlay:.roundedSquare, overlayColor:UIColor.black.withAlphaComponent(0) )
    //
    //        self.view.addSubview(spinner)
    //    }
    //    func spinnerStop(){
    //        let spinner = JHSpinnerView.showOnView(self.view, spinnerColor:UIColor.red, overlay:.roundedSquare, overlayColor:UIColor.black.withAlphaComponent(0) )
    //
    //        spinner.dismiss()
    //    }
    func unlock() {
        if let lockView = self.viewWithTag(10) {
            UIView.animate(withDuration: 0.2, animations: {
                lockView.alpha = 0.0
            }) { finished in
                lockView.removeFromSuperview()
            }
        }
    }
    @IBInspectable var shadowRadius: CGFloat{
        get{
            return self.layer.shadowRadius
        }
        set{
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float{
        get{
            return self.layer.shadowOpacity
        }
        set{
            self.layer.shadowOpacity = newValue
        }
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
//    func lock(frameRect: CGRect = CGRect.zero) {
//        if (viewWithTag(10) != nil) {
//            //View is already locked
//        }
//        else {
//            let lockView = UIView()
//
//            if frameRect == CGRect.zero{
//                lockView.frame = bounds
//            }
//            else{
//                lockView.frame = frameRect
//            }
//
//            lockView.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
//
//            lockView.tag = 10
//            lockView.alpha = 0.0
//
//
//
//            let activityIndicator = UIActivityIndicatorView(frame:CGRectMake(lockView.center.x,lockView.center.y, 50, 50))
//
//            activityIndicator.style = .whiteLarge
//            activityIndicator.center.x = lockView.center.x
//            activityIndicator.center.y = lockView.center.y
//            activityIndicator.color = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
//
//
//            activityIndicator.startAnimating()
//            lockView.addSubview(activityIndicator)
//            addSubview(lockView)
//
//            UIView.animate(withDuration: 0.2) {
//                lockView.alpha = 1.0
//            }
//        }
//    }
//
//    func unlock() {
//        if let lockView = self.viewWithTag(10) {
//            UIView.animate(withDuration: 0.2, animations: {
//                lockView.alpha = 0.0
//            }) { finished in
//                lockView.removeFromSuperview()
//            }
//        }
//    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
}
@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
extension UIImageView{
    func loadImage(_ url : URL?) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }
}
