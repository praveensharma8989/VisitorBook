//
//  UIView+PS.swift
//  structureCoversionDemo
//
//  Created by praveen on 28/09/17.
//  Copyright © 2017 mobikasa. All rights reserved.
//
import Foundation
import UIKit
import pop
@IBDesignable
extension UIView
{
    @IBInspectable
    public var cornerRadius :CGFloat {
        
        get {
            return layer.cornerRadius
        }
        set { layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
        
    }
    @IBInspectable
    public var borderWidth :CGFloat {
        
        get {
            return layer.borderWidth
        }
        set { layer.borderWidth = newValue
            //layer.masksToBounds = newValue > 0
        }
        
    }
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    //    @IBInspectable
    //    public var borderColor :CGColor {
    //        get {
    //            return layer.borderColor!
    //        }
    //        set { layer.borderColor = borderColor
    //        }
    //
    //      }
    
    func setShadowViewWithRoundShape()  {
        
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.masksToBounds = false
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        //
    }
    
    func setShadowView()  {
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.masksToBounds = false
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5

    }
    
    
    
    func setMove(_ constraint: NSLayoutConstraint, withMovePosition value: CGFloat?, withSpringBounce bounciness: CGFloat
        ) {
        let lbl_animation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        lbl_animation?.toValue = value
        if bounciness > 0 {
            lbl_animation?.springBounciness = bounciness
            lbl_animation?.springSpeed = 2
        }
        lbl_animation?.beginTime = CACurrentMediaTime()
        
        constraint.pop_add(lbl_animation, forKey: "moveanimation")
    }
    func setMoveIn(_ bounciness: CGFloat ,with MoveInCompletion:@escaping (Bool)->Void) {
        let lbl_animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        
        lbl_animation?.fromValue = CGRect(x: 0, y:self.frame.origin.y+200 , width:self.frame.size.width , height:self.frame.size.height)
        lbl_animation?.toValue = self.frame
        lbl_animation?.completionBlock = {(moveInanimation ,statuss) in
            MoveInCompletion(statuss)
        }
        lbl_animation?.removedOnCompletion = true
        if bounciness > 0 {
            lbl_animation?.springBounciness = bounciness
            lbl_animation?.springSpeed = 2
        }
        lbl_animation?.beginTime = CACurrentMediaTime()
        
        self.pop_add(lbl_animation, forKey: "moveInanimation")
    }
    func setMoveOut(_ bounciness: CGFloat ,with MoveInCompletion:@escaping (Bool)->Void) {
        let lbl_animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        lbl_animation?.toValue = CGRect(x: 0, y:self.frame.origin.y+200 , width:self.frame.size.width , height:self.frame.size.height)
        lbl_animation?.fromValue = self.frame
        lbl_animation?.completionBlock = {(moveInanimation ,statuss) in
            MoveInCompletion(statuss)
        }
        lbl_animation?.removedOnCompletion = true
        if bounciness > 0 {
            lbl_animation?.springBounciness = bounciness
            lbl_animation?.springSpeed = 2
        }
        lbl_animation?.beginTime = CACurrentMediaTime()
        
        self.pop_add(lbl_animation, forKey: "moveOutanimation")
    }
    
    func bounceeffect() {
        let sprintAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        sprintAnimation?.springBounciness = 20.0
        sprintAnimation?.removedOnCompletion = true
        
        sprintAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 1.3, y: 1.3))
        sprintAnimation?.toValue = NSValue(cgPoint: CGPoint(x: 1.0, y: 1.0))
        sprintAnimation?.velocity = NSValue(cgPoint: CGPoint(x: 2, y: 2))
        
        self.pop_add(sprintAnimation, forKey: "springAnimation")
        
    }
    func bounceeffect(completionBlock : @escaping (Bool)->Void) {
        let sprintAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        sprintAnimation?.springBounciness = 20.0
        sprintAnimation?.removedOnCompletion = true
        sprintAnimation?.completionBlock = {_,_ in
            completionBlock(true)
        }
        sprintAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 1.3, y: 1.3))
        sprintAnimation?.toValue = NSValue(cgPoint: CGPoint(x: 1.0, y: 1.0))
        sprintAnimation?.velocity = NSValue(cgPoint: CGPoint(x: 2, y: 2))
        
        self.pop_add(sprintAnimation, forKey: "springAnimation2")
        
        
    }
    func ZoomInAnimation() {
        if self.isHidden == true {
            let sprintAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            sprintAnimation?.springBounciness = 20.0
            sprintAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 0.3, y: 0.3))
            sprintAnimation?.toValue = NSValue(cgPoint: CGPoint(x: 1.0, y: 1.0))
            sprintAnimation?.velocity = NSValue(cgPoint: CGPoint(x: 2, y: 2))
            sprintAnimation?.removedOnCompletion = true
            sprintAnimation?.completionBlock = {_,_ in
                self.isHidden = false
            }
            self.pop_add(sprintAnimation, forKey: "springAnimation")
            
            
        }
        
    }
    func FadeOutFadeIn(){
        
        
    }
    
    func ZoomOutAnimation() {
        if self.isHidden == false {
            let sprintAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            sprintAnimation?.springBounciness = 20.0
            sprintAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 1.0, y: 1.0))
            sprintAnimation?.toValue = NSValue(cgPoint: CGPoint(x: 0.1, y: 0.1))
            sprintAnimation?.velocity = NSValue(cgPoint: CGPoint(x: 2, y: 2))
            sprintAnimation?.removedOnCompletion = true
            sprintAnimation?.completionBlock = {_,_ in
                self.isHidden = true
                
            }
            self.pop_add(sprintAnimation, forKey: "springAnimation")
        }
        
    }
    
    func setNoInternetView(completion:@escaping (Bool)->Void)
    {
        
        if(self.subviews.last?.isKind(of: CHFInternetView.self) == false){
            
            let nointernet : CHFInternetView = CHFInternetView(frame:CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
            
            nointernet.retrybuttonCallback = { Bool in
                
                if AppConstants.checkNet() == true {
                    //  nointernet.removeFromSuperview()
                    completion(self.removeNoInternet())
                    //completion(true)
                }
                else{
                    completion(false)
                }
                
                
            }
            self.addSubview(nointernet)
        }
        
        
    }
    func removeNoInternet()->Bool {
        
        if(self.subviews.last?.isKind(of: CHFInternetView.self) == true)
        {
            let nointernetview : CHFInternetView = self.subviews.last as! CHFInternetView
            // nointernetview.setMoveOut(2, with: { (status) in
            nointernetview.removeFromSuperview()
            //})
            return true
        }
        return false
    }
    
    func setNoInternetViewSmall(completion:@escaping (Bool)->Void )
    {
        if(self.subviews.last?.isKind(of: NoInternetViewSmall.self) == false){
            
            let nointernetsmall : NoInternetViewSmall = NoInternetViewSmall(frame:CGRect(x: 0, y: self.frame.size.height-60, width: self.frame.size.width, height: 60))
            
            nointernetsmall.retryButtonCompletion = { Bool in
                
                if AppConstants.checkNet() == true {
                    
                    completion(self.removeNoInternetSmall())
                }
                else{
                    completion(false)
                }
            }
            // nointernetsmall.alpha = 0
            self.addSubview(nointernetsmall)
            
            nointernetsmall.setMoveIn(2, with: { (status) in
            })
            if #available(iOS 10.0, *) {
                _ = Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { (timer) in
                    _ =  self.removeNoInternetSmall()
                }
            } else {
                // Fallback on earlier versions
            }
        }
        else{
            let nointernetsmall : NoInternetViewSmall = self.subviews.last as! NoInternetViewSmall
            nointernetsmall.setMoveIn(2, with: { (status) in
                
            })
        }
        
        
    }
    func removeNoInternetSmall()->Bool {
        
        if(self.subviews.last?.isKind(of: NoInternetViewSmall.self) == true)
        {
            
            let nointernetsmall : NoInternetViewSmall = self.subviews.last as! NoInternetViewSmall
            
            nointernetsmall.setMoveOut(2, with: { (status) in
                nointernetsmall.removeFromSuperview()
            })
            return true
        }
        return false
    }
}

