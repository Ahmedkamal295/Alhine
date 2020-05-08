//
//  ViewController.swift
//  jjjj
//
//  Created by Macbook on 4/25/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit
import Foundation

//public extension UITableView {
//    
//    typealias Complition = (() -> Void)
//    typealias HeaderFooterTuple = (header: UIView?, footer: UIView?)
//    typealias VisibleHeaderFooter = [Int: HeaderFooterTuple]
//    
//    public enum AnimationType {
//        case simple(duration: TimeInterval, direction: Direction, constantDelay: TimeInterval)
//        case spring(duration: TimeInterval, damping: CGFloat, velocity: CGFloat, direction: Direction, constantDelay: TimeInterval)
//        
//        public func animate(tableView: UITableView, reversed: Bool = false, completion: Complition? = nil) {
//            var duration: TimeInterval!
//            var damping: CGFloat = 1
//            var velocity: CGFloat = 0
//            var constantDelay: TimeInterval!
//            var direction: Direction!
//            
//            switch self {
//            case .simple(let _duration, let _direction, let _constantDelay):
//                duration = _duration
//                direction = _direction
//                constantDelay = _constantDelay
//            case .spring(let _duration, let _damping, let _velocity, let _direction, let _constantDelay):
//                duration = _duration
//                damping = _damping
//                velocity = _velocity
//                direction = _direction
//                constantDelay = _constantDelay
//            }
//            
//            let _ = tableView.visibleCells
//            let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows
//            let grouped = indexPathsForVisibleRows?.grouped(by: { (indexPath: IndexPath) -> Int in
//                return indexPath.section
//            }).sorted(by: { $0.key < $1.key })
//            
//            let visibleHeaderFooter = tableView.visibleSectionIndexes()
//            var visibleViews = [UIView]()
//            
//            for items in grouped! {
//                var currentViews: [UIView] = items.value.flatMap { tableView.cellForRow(at: $0) }
//                if let header = visibleHeaderFooter[items.key]?.header {
//                    currentViews.insert(header, at: 0)
//                }
//                
//                if let footer = visibleHeaderFooter[items.key]?.footer {
//                    currentViews.append(footer)
//                }
//                
//                visibleViews += currentViews
//            }
//            
//            let visibleCellsCount = Double(visibleViews.count)
//            let cells = direction.reverse(for: reversed ? visibleViews.reversed() : visibleViews)
//            cells.enumerated().forEach { item in
//                let delay: TimeInterval = duration / visibleCellsCount * Double(item.offset) + Double(item.offset) * constantDelay
//                direction.startValues(tableView: tableView, for: item.element)
//                let anchor = item.element.layer.anchorPoint
//                
//                UIView.animate(
//                    withDuration: duration,
//                    delay: delay,
//                    usingSpringWithDamping: damping,
//                    initialSpringVelocity: velocity,
//                    options: .curveEaseInOut,
//                    animations: {
//                        direction.endValues(tableView: tableView, for: item.element)
//                }, completion: { finished in
//                    item.element.layer.anchorPoint = anchor
//                    completion?()
//                })
//                
//                //                print(duration, delay)
//            }
//            
//        }
//    }
//    
//    public enum Direction {
//        case left(useCellsFrame: Bool)
//        case top(useCellsFrame: Bool)
//        case right(useCellsFrame: Bool)
//        case bottom(useCellsFrame: Bool)
//        case rotation(angle: Double)
//        case rotation3D(type: TransformType)
//        
//        // For testing only
//        init?(rawValue: Int, useCellsFrame: Bool) {
//            switch rawValue {
//            case 0:
//                self = Direction.left(useCellsFrame: useCellsFrame)
//            case 1:
//                self = Direction.top(useCellsFrame: useCellsFrame)
//            case 2:
//                self = Direction.right(useCellsFrame: useCellsFrame)
//            case 3:
//                self = Direction.bottom(useCellsFrame: useCellsFrame)
//            case 4:
//                self = Direction.rotation(angle: -Double.pi / 2)
//            default:
//                return nil
//            }
//        }
//        
//        func startValues(tableView: UITableView, for cell: UIView) {
//            cell.alpha = 0
//            switch self {
//            case .left(let useCellsFrame):
//                cell.frame.origin.x += useCellsFrame ? cell.frame.width : tableView.frame.width
//            case .top(let useCellsFrame):
//                cell.frame.origin.y += useCellsFrame ? cell.frame.height : tableView.frame.height
//            case .right(let useCellsFrame):
//                cell.frame.origin.x -= useCellsFrame ? cell.frame.width : tableView.frame.width
//            case .bottom(let useCellsFrame):
//                cell.frame.origin.y -= useCellsFrame ? cell.frame.height : tableView.frame.height
//            case .rotation(let angle):
//                cell.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
//            case .rotation3D(let type):
//                type.set(for: cell)
//            }
//        }
//        
//        func endValues(tableView: UITableView, for cell: UIView) {
//            cell.alpha = 1
//            switch self {
//            case .left(let useCellsFrame):
//                cell.frame.origin.x -= useCellsFrame ? cell.frame.width : tableView.frame.width
//            case .top(let useCellsFrame):
//                cell.frame.origin.y -= useCellsFrame ? cell.frame.height : tableView.frame.height
//            case .right(let useCellsFrame):
//                cell.frame.origin.x += useCellsFrame ? cell.frame.width : tableView.frame.width
//            case .bottom(let useCellsFrame):
//                cell.frame.origin.y += useCellsFrame ? cell.frame.height : tableView.frame.height
//            case .rotation(_):
//                cell.transform = .identity
//            case .rotation3D(_):
//                cell.layer.transform = CATransform3DIdentity
//            }
//        }
//        
//        func reverse(for cells: [UIView]) -> [UIView] {
//            switch self {
//            case .bottom(_):
//                return cells.reversed()
//            default:
//                return cells
//            }
//        }
//        
//        public enum TransformType {
//            case ironMan
//            case thor
//            case spiderMan
//            case captainMarvel
//            case hulk
//            case daredevil
//            case deadpool
//            case doctorStrange
//            
//            func set(for cell: UIView) {
//                let oldFrame = cell.frame
//                var transform = CATransform3DIdentity
//                transform.m34 = 1.0 / -500
//                
//                switch self {
//                case .ironMan:
//                    cell.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
//                    transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 0, 1, 0)
//                case .thor:
//                    cell.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
//                    transform = CATransform3DRotate(transform, -CGFloat(Double.pi / 2), 0, 1, 0)
//                case .spiderMan:
//                    cell.layer.anchorPoint = .zero
//                    transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 0, 1, 1)
//                case .captainMarvel:
//                    cell.layer.anchorPoint = CGPoint(x: 1, y: 1)
//                    transform = CATransform3DRotate(transform, -CGFloat(Double.pi / 2), 1, 1, 1)
//                case .hulk:
//                    cell.layer.anchorPoint = CGPoint(x: 1, y: 1)
//                    transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 1, 1, 1)
//                case .daredevil:
//                    cell.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
//                    transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 0, 1, 0)
//                case .deadpool:
//                    cell.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
//                    transform = CATransform3DRotate(transform, CGFloat(Double.pi / 2), 1, 0, 1)
//                case .doctorStrange:
//                    cell.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
//                    transform = CATransform3DRotate(transform, -CGFloat(Double.pi / 2), 1, 0, 0)
//                }
//                
//                cell.frame = oldFrame
//                cell.layer.transform = transform
//            }
//        }
//    }
//    
//    public func reloadData(with animation: AnimationType, reversed: Bool = false, completion: Complition? = nil) {
//        reloadData()
//        animation.animate(tableView: self, reversed: reversed, completion: completion)
//    }
//}
//
//extension UITableView {
//    fileprivate func visibleSectionIndexes() -> VisibleHeaderFooter {
//        let visibleTableViewRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: bounds.size.width, height: bounds.size.height)
//        
//        var visibleHeaderFooter: VisibleHeaderFooter = [:]
//        (0..<numberOfSections).forEach {
//            let headerRect = rectForHeader(inSection: $0)
//            let footerRect = rectForFooter(inSection: $0)
//            
//            let header: UIView? = visibleTableViewRect.intersects(headerRect) ? headerView(forSection: $0) : nil
//            let footer: UIView? = visibleTableViewRect.intersects(footerRect) ? footerView(forSection: $0) : nil
//            
//            let headerFooterTuple: HeaderFooterTuple = (header: header, footer: footer)
//            visibleHeaderFooter[$0] = headerFooterTuple
//        }
//        
//        return visibleHeaderFooter
//    }
//}

extension Array {
    fileprivate func grouped<T>(by criteria: (Element) -> T) -> [T: [Element]] {
        var groups = [T: [Element]]()
        for element in self {
            let key = criteria(element)
            if groups.keys.contains(key) == false {
                groups[key] = [Element]()
            }
            groups[key]?.append(element)
        }
        return groups
    }
}





extension String{
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
@IBDesignable
class DesignableUITextField: UITextField {
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
}
//extension UIView {
//    
//    // extension CornerRadius
//    @IBInspectable
//    var cornerRadiuss: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//    // extension BorderWidth
//    @IBInspectable
//    var borderWidthh: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//    // extension BorderColor
//    @IBInspectable
//    var borderColorr: UIColor? {
//        get {
//            let color = UIColor.init(cgColor: layer.borderColor!)
//            return color
//        }
//        set {
//            layer.borderColor = newValue?.cgColor
//        }
//    }
//    // extension ShadowRadius
//    @IBInspectable
//    var shadowRadiuss: CGFloat {
//        get {
//            return layer.shadowRadius
//        }
//        set {
//            layer.shadowColor = UIColor.black.cgColor
//            layer.shadowOffset = CGSize(width: 0, height: 2)
//            layer.shadowOpacity = 0.4
//            layer.shadowRadius = shadowRadius
//        }
//    }
//    
//    func rightValidAccessoryView() -> UIView {
//        let imgView = UIImageView(image: UIImage(named: "check_valid"))
//        imgView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//        imgView.backgroundColor = UIColor.clear
//        return imgView
//    }
//    
//    func rightInValidAccessoryView() -> UIView {
//        let imgView = UIImageView(image: UIImage(named: "check_invalid"))
//        imgView.frame = CGRect(x: self.cornerRadius, y: self.cornerRadius, width: 20, height: 20)
//        imgView.backgroundColor = UIColor.clear
//        return imgView
//    }
//    
//}

// extension HideKeyboard when Tapped
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
    public class AGCustomButton: UIButton {
        //MARK: - Gradient
        private var gradient:CAGradientLayer = CAGradientLayer()
        
        @IBInspectable var enableGradient: Bool = false
        

    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0) {
        didSet {
            gradient.startPoint = startPoint
        }
    }
    
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0) {
        didSet {
            gradient.endPoint = endPoint
          }
        }
        @IBInspectable var primaryColor: UIColor = UIColor.white {
            didSet {
                gradient.colors = [primaryColor.cgColor, secundaryColor.cgColor]
            }
        }
        
        @IBInspectable var secundaryColor: UIColor = UIColor.black {
            didSet {
                gradient.colors = [primaryColor.cgColor, secundaryColor.cgColor]
            }
            
    }
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupAGCustomControl()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupAGCustomControl()
        }
        
        override public func prepareForInterfaceBuilder() {
            super .prepareForInterfaceBuilder()
            setupAGCustomControl()
        }
        
        private func setupAGCustomControl(){
            self.backgroundColor = UIColor.clear
            self.layer.cornerRadius = cornerRadius
//            self.layer.shadowColor = UIColor.clear as! CGColor
//            self.layer.shadowOffset = titleShadowOffset
//            self.layer.shadowOpacity = shadowOpacity
            self.layer.shadowRadius = shadowRadius
            setupGradient()
        }
        
        private func setupGradient(){
            if (enableGradient){
                gradient.colors = [primaryColor.cgColor, secundaryColor.cgColor]
                gradient.frame = self.bounds
                gradient.startPoint = startPoint
                gradient.endPoint = endPoint
                gradient.cornerRadius = cornerRadius
                self.layer.insertSublayer(gradient, at: 0)
            }else{
                gradient.removeFromSuperlayer()
            }
        }
        
}

class CircularTransition: NSObject {
    
    var circle = UIView()
    
    var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    
    var circleColor = UIColor.white
    
    var duration = 0.3
    
    enum CircularTransitionMode:Int {
        case present, dismiss, pop
    }
    
    var transitionMode:CircularTransitionMode = .present
    
}

extension CircularTransition:UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circle = UIView()
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                    
                }, completion: { (success:Bool) in
                    transitionContext.completeTransition(success)
                })
            }
            
        }else{
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    
                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.circle, belowSubview: returningView)
                    }
                    
                    
                }, completion: { (success:Bool) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    
                    self.circle.removeFromSuperview()
                    
                    transitionContext.completeTransition(success)
                    
                })
                
            }
            
            
        }
        
    }
    
    
    
    func frameForCircle (withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offestVector, height: offestVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
