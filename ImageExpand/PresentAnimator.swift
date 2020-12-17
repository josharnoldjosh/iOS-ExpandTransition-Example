//
//  PresentAnimator.swift
//  ImageExpand
//
//  Created by Josh Arnold on 12/15/20.
//

import Foundation
import UIKit


class PresentAnimator : NSObject, UIViewControllerAnimatedTransitioning {

    
    private var duration:TimeInterval
    
    
    init(duration:TimeInterval) {
        self.duration = duration
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
                        
        guard let startVC = transitionContext.viewController(forKey: .from) as? ExpandTransitionDriver else {
            print("ExpandTransitionDriver not implemented!")
            return
        }
        
        guard let finishVC = transitionContext.viewController(forKey: .to) as? ExpandTransitionDriver else {
            print("ExpandTransitionDriver not implemented!")
            return
        }
                
        let dim = getDimView()
        transitionContext.containerView.addSubview(dim)
                
        let image = getImageView(startVC: startVC)
        transitionContext.containerView.addSubview(image)
                        
        animate(transitionContext: transitionContext, dim: dim, image: image, finishVC: finishVC)
    }
}


extension PresentAnimator {
    
    func animate(transitionContext:UIViewControllerContextTransitioning, dim:UIView, image:UIImageView, finishVC:ExpandTransitionDriver) {
        
        UIView.animate(withDuration: min(0.3, self.duration)) {
            dim.alpha = 0.5
        }
        
        UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.25, options: .curveEaseInOut) {
            
            image.frame = finishVC.getImageView().frame
            image.layer.cornerRadius = finishVC.getImageView().layer.cornerRadius
            
        } completion: { (success) in
            
            transitionContext.containerView.addSubview(finishVC.view)
            image.removeFromSuperview()
            dim.removeFromSuperview()
            transitionContext.completeTransition(success)
        }
    }
    
    func getImageView(startVC:ExpandTransitionDriver) -> UIImageView {
        let image = UIImageView()
        image.frame = startVC.getImageView().frame
        image.image = startVC.getImageView().image
        image.layer.cornerRadius = startVC.getImageView().layer.cornerRadius
        image.contentMode = startVC.getImageView().contentMode
        image.clipsToBounds = startVC.getImageView().clipsToBounds
        return image
    }
    
    func getDimView() -> UIView {
        let dim = UIView()
        dim.backgroundColor = UIColor.black
        dim.alpha = 0
        dim.frame = UIScreen.main.bounds
        return dim
    }
}
