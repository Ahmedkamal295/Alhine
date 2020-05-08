//
//  5.swift
//  TYOUT
//
//  Created by Ali Hamed on 9/25/18.
//  Copyright © 2018 Gra7. All rights reserved.
//

import UIKit
import Kingfisher
import AudioToolbox
//import StatusAlert
import LXStatusAlert
import UIView_Shake
import SwiftMessages





extension UITextField {
    
    func setPadding(left: CGFloat? = nil, right: CGFloat? = nil){
        if let left = left {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        
        if let right = right {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
    
}


extension UIView {
    
    
    
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    
    
    func checkBoxButton(sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { _ in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
        
    }
    
    func setupAnimate(_ sender: Any) {
        let theButton = sender as! UIButton
        
        let bounds = theButton.bounds
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 10,
                       options: .curveEaseInOut,
                       animations: {
                        theButton.bounds = CGRect(x: bounds.origin.x - 10, y: bounds.origin.y,
                                                  width: bounds.size.width + 25, height: bounds.size.height)
        }) { (success: Bool) in
            if success {
                
                UIView.animate(withDuration: 0.5, animations: {
                    theButton.bounds = bounds
                })
                
            }
        }
    }
    
}
    
    
    
    
    

extension UIViewController : UIGestureRecognizerDelegate{
    
    
    
    @IBAction func backClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dismissClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
//    @IBAction func notificationClicked(_ sender: Any) {
//        let storyboard = UIStoryboard.init(name: "UserLanding", bundle: nil)
//        let vc  = storyboard.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
//        self.navigationController?.pushViewController(vc, animated: true)
//        
//    }
//    @IBAction func messagesClicked(_ sender: Any) {
//        let storyboard = UIStoryboard.init(name: "GuidLanding", bundle: nil)
//        let vc  = storyboard.instantiateViewController(withIdentifier: "MessagesVC") as! MessagesVC
//        self.navigationController?.pushViewController(vc, animated: true)
//        
//    }
    func showMessage(title: String? = nil, sub: String?, type: Theme = .warning, layout: MessageView.Layout = .statusLine) {
        // Instantiate a message view from the provided card view layout. SwiftMessages searches for nib
        // files in the main bundle first, so you can easily copy them into your project and make changes.
        let view = MessageView.viewFromNib(layout: layout)
        
        // Theme message elements with the warning style.
        view.configureTheme(type)
        view.button?.isHidden = true
        
        if type == .error {
            self.view.shake()
            Vibration.error.vibrate()
        }
        // Add a drop shadow.
        //        view.configureDropShadow()
        
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        
        view.configureContent(title: title ?? "", body: sub ?? "", iconText: "")
        
        // Show the message.
        SwiftMessages.show(view: view)
    }
   
    
    func addPopGesture() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func alert(msg:String) {
        let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    func isNotEmptyString(text: String, withAlertMessage message: String) -> Bool{
        if text == ""{
            //            showAlertWithTitle(title: "Empty Field".localized, message: message, type: .error);
            showMessage(title: "Empty Field".localized, sub: message, type: .error, layout: .statusLine)
            //            Vibration.error.vibrate()
            
            return false
        }
        else{
            return true
        }
    }
    func showStatus(image: UIImage , message: String){
//        let statusAlert = StatusAlert()
//        statusAlert.image = image
//        statusAlert.title = title
//        statusAlert.message = message
////        statusAlert.canBePickedOrDismissed = isUserInteractionAllowed
//        statusAlert.canBePickedOrDismissed = true
//        statusAlert.showInKeyWindow()
        let statusAlert = LXStatusAlert(image: image, title:message, duration: 3.0)
        statusAlert.show()

    }
    func alertSkipLogin(){
        let alert = UIAlertController.init(title: "Warning".localized , message: "please login first".localized ,  preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        
        
        let cancelAction = UIAlertAction.init(title: "Ok".localized, style: .cancel, handler: { (nil) in
            
//            appDelegate.setRoot(storyBoard: .authentication, vc: .splash)
            
            
        })
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func setShadow(view : UIView , width : Int , height: Int , shadowRadius: CGFloat , shadowOpacity: Float , shadowColor: CGColor){
        // to make the shadow with rounded corners and offset shadow form the bottom
        view.layer.shadowColor = shadowColor
        view.layer.shadowOffset = CGSize(width: width, height: height)
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOpacity = shadowOpacity
        view.clipsToBounds = true
        view.layer.masksToBounds = false
    }
    enum Vibration {
        case error
        case success
        case warning
        case light
        case medium
        case heavy
        case selection
        case oldSchool
        func vibrate() {
            
            switch self {
            case .error:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
                
            case .success:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                
            case .warning:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.warning)
                
            case .light:
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
                
            case .medium:
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                
            case .heavy:
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
                
            case .selection:
                let generator = UISelectionFeedbackGenerator()
                generator.selectionChanged()
                
            case .oldSchool:
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            
        }
        
    }
    func showAlertWithTitle(title: String, message: String, type: ISAlertType) {
        ISMessages.showCardAlert(withTitle: title, message: message, duration: 3.5, hideOnSwipe: true, hideOnTap: true, alertType: type, alertPosition: .top, didHide: nil)
        if type == .error{
            self.view.shake()
        }
    }
    func changeLanguage(storyBoard: String = "Main", vcId: storyBoardVCIDs) {
        let transition: UIView.AnimationOptions = .transitionCrossDissolve
        
        if L102Language.currentAppleLanguage() == englishLang {
            L102Language.setAppleLAnguageTo(lang: arabicLang)
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            L102Language.setAppleLAnguageTo(lang: englishLang)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        let storyBoard: UIStoryboard = UIStoryboard.init(name: storyBoard, bundle: nil)
        
        
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootviewcontroller.rootViewController = storyBoard.instantiateViewController(withIdentifier: vcId.rawValue)
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            
        }
    }
//    func changeLanguage() {
//        let transition: UIView.AnimationOptions = .transitionCrossDissolve
//
//        if L102Language.currentAppleLanguage() == englishLang {
//            L102Language.setAppleLAnguageTo(lang: arabicLang)
//            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//        } else {
//            L102Language.setAppleLAnguageTo(lang: englishLang)
//            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//        }
//
//        let storyBoard: UIStoryboard = UIStoryboard.init(name: "Landing", bundle: nil)
//
//
//        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
//        rootviewcontroller.rootViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController")
//        let mainwindow = (UIApplication.shared.delegate?.window!)!
//        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
//        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
//        }) { (finished) -> Void in
//
//        }
//    }
    
    func performSegueTo(storyBoard: storyBoardName, vc: storyBoardVCIDs) {
        let sb = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        let vcNew = sb.instantiateViewController(withIdentifier: vc.rawValue)
        self.navigationController?.pushViewController(vcNew, animated: true)
//        show(vcNew, sender: self)
        
    }
    
    
    
}
extension UIScreen {
    var minEdge: CGFloat {
        return UIScreen.main.bounds.minEdge
    }
}
extension CGRect {
    var minEdge: CGFloat {
        return min(width, height)
    }
}
extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
