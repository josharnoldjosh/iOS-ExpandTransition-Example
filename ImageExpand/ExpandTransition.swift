//
//  ExpandTransition.swift
//  ImageExpand
//
//  Created by Josh Arnold on 12/15/20.
//

import Foundation
import UIKit


protocol ExpandTransitionDriver : UIViewController {
    func getImageView() -> UIImageView
}


class ExpandTransition : NSObject, UIViewControllerTransitioningDelegate {
        
    
    var presentor:PresentAnimator
    var dismiss:DismissAnimator
    
    
    init(start:ExpandTransitionDriver, finish:ExpandTransitionDriver, duration:TimeInterval=0.75) {        
        self.presentor = PresentAnimator(duration: duration)
        self.dismiss = DismissAnimator(startVC: start, finishVC: finish, duration: duration)
        super.init()        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentor
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismiss
    }
}
