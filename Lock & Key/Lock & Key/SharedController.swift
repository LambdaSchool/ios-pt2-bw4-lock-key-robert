//
//  SharedController.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 2/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation
import UIKit

class SharedController {
    
    //MARK: - Animation Methods
    
    func rotateKeysLeft(for button: UIButton) {
        UIView.animate(withDuration: 4.0, animations: {
            button.transform = CGAffineTransform(rotationAngle: -.pi/2)
        })
    }
    
    func rotateKeysDown(for button: UIButton) {
        UIView.animate(withDuration: 4.0, animations: {
            button.transform = CGAffineTransform(rotationAngle: -.pi)
        })
    }
    
    func rotateKeysRight(for button: UIButton) {
        UIView.animate(withDuration: 4.0, animations: {
            button.transform = CGAffineTransform(rotationAngle: .pi/2)
        })
    }
    
    func rotateKeysUp(for button: UIButton) {
        UIView.animate(withDuration: 4.0, animations: {
            button.transform = CGAffineTransform(rotationAngle: 0)
        })
    }
    
    func fadeKeysIn(for button: UIButton) {
        UIView.animate(withDuration: 4.0, animations: {
            button.alpha = 1.0
        })
    }
    
    //MARK: - Riddle Methods
    
    
    
    
    
}
