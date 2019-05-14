//
//  DetailsCell.swift
//  fluid
//
//  Created by Ziyad Khalil on 5/13/19.
//  Copyright © 2019 Ziyad Khalil. All rights reserved.
//

import UIKit
enum DetailsCellState {
    case swipedRight
    case swipedLeft
    case normal
}
enum DetailsCellType {
    case task
    case note
    case event
}

var swipedCell: DetailsCell!
class DetailsCell: UITableViewCell {
    @IBOutlet weak var doneView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var removeView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    weak var detailsViewController: DetailsViewController?
    var doneSwipingAction: (()->())?
    var removeSwipingAction: (()->())?
    let defaultLeftConstant: CGFloat! = -75
    var initial: CGFloat! = 0
    var initialState: DetailsCellState! = .normal
    var state: DetailsCellState! = .normal
    override func awakeFromNib() {
        super.awakeFromNib()
        initial = 0
        state = .normal
        initialState = .normal
    }
    @objc func swipe(_ gest:UIPanGestureRecognizer){
        let translation = gest.translation(in: mainView.superview)
        if gest.state == .began {
            initial = constraint.constant
            initialState = self.state
            if swipedCell != nil && swipedCell != self{
                swipedCell.constraint.constant = defaultLeftConstant
                UIView.animate(withDuration: 0.3) {
                    swipedCell.layoutIfNeeded()
                }
                swipedCell.state = .normal
                swipedCell = nil
                
            }
        }
        if gest.state != .cancelled {
            if !(initial + translation.x > 0 || initial + translation.x < -150)  {
                constraint.constant = initial + translation.x
            }
        }
        if gest.state == .ended {
            if constraint.constant >= defaultLeftConstant/2 && constraint.constant <= 0 {
                constraint.constant = 0
                UIView.animate(withDuration: 0.3) {
                    self.layoutIfNeeded()
                }
                self.state = .swipedRight
                swipedCell = self
            }
            else if constraint.constant <= defaultLeftConstant/2 && constraint.constant > defaultLeftConstant/2 + defaultLeftConstant {
                constraint.constant = defaultLeftConstant
                UIView.animate(withDuration: 0.3) {
                    self.layoutIfNeeded()
                }
                self.state = .normal
            }
            else {
                constraint.constant = 2*defaultLeftConstant
                UIView.animate(withDuration: 0.3) {
                    self.layoutIfNeeded()
                }
                self.state = .swipedLeft
                swipedCell = self
            }
        }
    }
    @objc func doneTapped(_:UITapGestureRecognizer){
        swipedCell.constraint.constant = defaultLeftConstant
        UIView.animate(withDuration: 0.3) {
            swipedCell.layoutIfNeeded()
        }
        swipedCell.state = .normal
        swipedCell = nil
        doneSwipingAction?()
    }
    @objc func removeTapped(_:UITapGestureRecognizer){
        swipedCell.constraint.constant = defaultLeftConstant
        UIView.animate(withDuration: 0.3) {
            swipedCell.layoutIfNeeded()
        }
        swipedCell.state = .normal
        swipedCell = nil
        removeSwipingAction?()
    }
}
