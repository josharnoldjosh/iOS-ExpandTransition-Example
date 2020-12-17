//
//  DimissAnimator.swift
//  ImageExpand
//
//  Created by Josh Arnold on 12/15/20.
//

import Foundation
import UIKit
import Closures


class DismissAnimator : NSObject, UIViewControllerAnimatedTransitioning {

    
    private var startVC:ExpandTransitionDriver
    private var finishVC:ExpandTransitionDriver
    private var duration:TimeInterval
    private var dim:UIView?
    private var cover:UIView?
    
    
    init(startVC:ExpandTransitionDriver, finishVC:ExpandTransitionDriver, duration:TimeInterval) {
        self.startVC = startVC
        self.finishVC = finishVC
        self.duration = duration
        super.init()
        handlePan()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.finishVC.view.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.dim?.alpha = 0
        } completion: { (success) in
            self.dim?.removeFromSuperview()
        }
        
        let image = UIImageView()
        image.frame = finishVC.view.frame
        image.image = finishVC.getImageView().image
        image.layer.cornerRadius = finishVC.getImageView().layer.cornerRadius
        image.contentMode = finishVC.getImageView().contentMode
        image.clipsToBounds = finishVC.getImageView().clipsToBounds
        transitionContext.containerView.addSubview(image)
        
        UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.25, options: .curveEaseInOut) {
            
            image.frame = self.startVC.getImageView().frame
            image.layer.cornerRadius = self.startVC.getImageView().layer.cornerRadius
            
        } completion: { (success) in
            image.removeFromSuperview()
            self.cover?.removeFromSuperview()
            transitionContext.completeTransition(success)
        }
        
    }
}


extension DismissAnimator {
    
    private func handlePan() {
        self.finishVC.view.addPanGesture { (pan) in
            if pan.state == .began {
                self.setupPan()
            }
            
            if pan.state == .changed {
                self.changePan(pan: pan)
            }
            
            if pan.state == .ended || pan.state == .cancelled {
                self.finishPan()
            }
        }
    }
    
    func setupPan() {
        cover = UIView()
        cover?.backgroundColor = .systemBackground
        cover?.frame = self.startVC.getImageView().frame
        startVC.view.addSubview(cover!)
        
        dim = UIView()
        dim?.backgroundColor = .black
        dim?.frame = startVC.view.frame
        dim?.alpha = 0.5
        startVC.view.addSubview(dim!)
        
        UIView.animate(withDuration: 0.35) {
            self.finishVC.view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }
    }
    
    func changePan(pan: UIPanGestureRecognizer) {
        self.finishVC.view.frame.origin.x += pan.translation(in: nil).x
        self.finishVC.view.frame.origin.y += pan.translation(in: nil).y
        pan.setTranslation(.zero, in: nil)
    }
    
    func finishPan() {
        if (self.finishVC.view.frame.origin.x > 150) {
            self.finishVC.dismiss(animated: true, completion: nil)
            return
        }
        
        UIView.animate(withDuration: 0.25) {
            self.finishVC.view.transform = .identity
            self.finishVC.view.frame.origin = .zero
        } completion: { (success) in
            self.dim?.removeFromSuperview()
            self.cover?.removeFromSuperview()
        }
    }
}
