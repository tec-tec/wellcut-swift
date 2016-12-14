//
//  CommonExtensions.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 14/12/2016.
//  Copyright © 2016 Ludovic Ollagnier. All rights reserved.
//

import UIKit

extension UIColor {
    static var wellcutYellow: UIColor {
        return UIColor(red: 253.0/255.0, green: 211.0/255, blue: 29.0/255, alpha: 1)
    }
}

extension UIView {
    func shake() {
        UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.33, animations: {
                self.transform = CGAffineTransform(translationX: -5, y: 0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.33, animations: {
                self.transform = CGAffineTransform(translationX: 5, y: 0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 0.33, animations: {
                self.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }) { (completed) in
            
        }
    }
}
