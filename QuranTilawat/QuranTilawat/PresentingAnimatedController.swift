//
//  PresentingAnimatedController.swift
//  QuranTilawat
//
//  Created by Hussain Shabbir on 10/22/16.
//  Copyright © 2016 Hussain Shabbir. All rights reserved.
//

import UIKit

class PresentingAnimatedController: NSObject,UIViewControllerAnimatedTransitioning {
    var sourceFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        let finalFrame = transitionContext.finalFrame(for: toVC)
        containerView.addSubview(toVC.view)
        toVC.view.frame = CGRect(x: finalFrame.size.width/2, y: 0, width: finalFrame.size.width, height: finalFrame.size.height)
        fromVC.view.alpha = 0.9
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.0, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
         toVC.view.frame = finalFrame
            },completion: { (finished) in
                fromVC.view.alpha = 1.0
                transitionContext.completeTransition(true)
            })
    }
}
