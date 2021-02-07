//
//  Extensions.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 28.01.2021.
//

import UIKit

extension UIView {
    func showAlert(title: String, message: String, negativeActionTitle: String? = nil, positiveActionTitle: String, negativeActionHandler: ((UIAlertAction) -> Void)? = nil, positiveActionHandler: ((UIAlertAction) -> Void)? = nil) {
                
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let negativeActionTitle = negativeActionTitle {
            let negativeAction = UIAlertAction(title: negativeActionTitle, style: .destructive, handler: negativeActionHandler)
            alertController.addAction(negativeAction)
        }
        
        let positiveAction = UIAlertAction(title: positiveActionTitle, style: .default, handler: positiveActionHandler)
        alertController.addAction(positiveAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

extension UIButton {
    convenience init(title: String, backgroundColor: UIColor? = nil, cornerRadius: CGFloat = 0.0, contentHorizontalAlignment: UIControl.ContentHorizontalAlignment = .center) {
        self.init(type: .system)

        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.contentHorizontalAlignment = contentHorizontalAlignment
    }
    
    convenience init(imageNamed: String, tintColor: UIColor!) {
        self.init(type: .system)
        
        let img = UIImage(named: imageNamed)?.withRenderingMode(.alwaysTemplate)
        self.tintColor = tintColor
        self.setImage(img, for: .normal)
    }
    
    convenience init(image: UIImage?, tintColor: UIColor!) {
        self.init(type: .system)
        
        self.setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.tintColor = tintColor
    }
}

extension UILabel {
    convenience init(title: String, font: UIFont, textAlignment: NSTextAlignment = .natural, numberOfLines: Int = 1, height: CGFloat? = nil) {
        self.init()
        
        self.text = title
        self.font = font
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        
        if let height = height {
            self.constrainHeight(constant: height)
        }
    }
}


extension UITextView {
    convenience init(title: String? = nil, font: UIFont, textAlignment: NSTextAlignment = .natural, height: CGFloat? = nil) {
        self.init()
        
        if let title = title {
            self.text = title
        }
        
        self.textAlignment = textAlignment
        self.textContainerInset.left = 2
        self.textContainerInset.right = 2
        self.isEditable = false
        self.font = font
        self.backgroundColor = .clear
        
        if let height = height {
            self.constrainHeight(constant: height)
        }
        
        self.isScrollEnabled = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
    }
}
