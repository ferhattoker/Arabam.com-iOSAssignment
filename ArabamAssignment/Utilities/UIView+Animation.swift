//
//  UIView+Animation.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 28.01.2021.
//

import UIKit

extension UIView {
    func animShow() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
}

