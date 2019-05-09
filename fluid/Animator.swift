//
//  Animator.swift
//  fluid
//
//  Created by Ziyad Khalil on 5/7/19.
//  Copyright © 2019 Ziyad Khalil. All rights reserved.
//

import UIKit

class Animator: NSObject {
    enum TransitionMode: Int {
        case Present, Dismss
    }
    
    var transitionMode: TransitionMode = .Present
    
    let presentDuration = 0.5
    let dissmissDuration = 0.3
    
    
    
    
}

extension Animator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionMode == .Present ? presentDuration : dissmissDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
}
