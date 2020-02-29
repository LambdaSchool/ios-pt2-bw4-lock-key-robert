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
    
    func endFreePlayAlert(viewController: UIViewController, segue: String) {
        
        let freeAlert = UIAlertController(title: "This is the end of the free game!", message: "If you wish to continue, please unlock the final 2 levels", preferredStyle: .alert)
        
        freeAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            viewController.performSegue(withIdentifier: segue, sender: viewController)
        }))
        
        viewController.present(freeAlert, animated: true, completion: nil)
    }
    
    func addRiddleAlert(riddle: String, answer: String, clue: String, viewController: UIViewController, button: UIButton?, gesture: UIGestureRecognizer?, segue: String) {
        
           let riddleAlert = UIAlertController(title: riddle, message: "", preferredStyle: UIAlertController.Style.alert)
           riddleAlert.addTextField(configurationHandler: { (textField) in
               textField.placeholder = "Enter correct answer:"
           })
        
           riddleAlert.addAction(UIAlertAction(title: "Submit", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
               guard let guess = riddleAlert.textFields![0].text?.lowercased() else { return }
               
               if guess == answer {
                   riddleAlert.message = ""
                   riddleAlert.dismiss(animated: true, completion: nil)
                   self.addGestureAlert(with: clue, viewController: viewController)
                   button?.isEnabled = true
                   gesture?.isEnabled = true
               } else {
                   CATransaction.setCompletionBlock({
                       self.addRejectedAlert(for: viewController, riddle: riddle, answer: answer, clue: clue, button: button, gesture: gesture, segue: segue)
                   })
               }
           }))
           riddleAlert.addAction(UIAlertAction(title: "Home", style: UIAlertAction.Style.cancel, handler: { _ in
               viewController.performSegue(withIdentifier: segue, sender: viewController)
           }))
           
           viewController.present(riddleAlert, animated: true, completion: nil)
       }
    
    private func addRejectedAlert(for viewController: UIViewController, riddle: String, answer: String, clue: String, button: UIButton?, gesture: UIGestureRecognizer?, segue: String) {
        let rejectedAlert = UIAlertController(title: "❌", message: "Wrong Answer", preferredStyle: UIAlertController.Style.alert)
        rejectedAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { _ in
            self.addRiddleAlert(riddle: riddle, answer: answer, clue: clue, viewController: viewController, button: button, gesture: gesture, segue: segue)
        }))
        viewController.present(rejectedAlert, animated: true, completion: nil)
    }
    
    func addTransitionRiddleAlert(riddle: String, answer: String, viewController: UIViewController, segue: String, level: String, segue2: String) {
        let transitionRiddleAlert = UIAlertController(title: "Level \(level) Complete!", message: riddle, preferredStyle: UIAlertController.Style.alert)
        transitionRiddleAlert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter correct answer:"
        })
        transitionRiddleAlert.addAction(UIAlertAction(title: "Submit", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            guard let guess = transitionRiddleAlert.textFields![0].text?.lowercased() else { return }
            
            if guess == answer {
                transitionRiddleAlert.message = ""
                transitionRiddleAlert.dismiss(animated: true, completion: nil)
                viewController.performSegue(withIdentifier: segue, sender: viewController)
            } else {
                self.addRejectedTransitionAlert(for: viewController, riddle: riddle, answer: answer, segue: segue, level: level, segue2: segue2)
            }
        }))
        
        transitionRiddleAlert.addAction(UIAlertAction(title: "Home", style: UIAlertAction.Style.cancel, handler: { _ in
            viewController.performSegue(withIdentifier: segue2, sender: viewController)
        }))

        viewController.present(transitionRiddleAlert, animated: true, completion: nil)
    }
    
    private func addRejectedTransitionAlert(for viewController: UIViewController, riddle: String, answer: String, segue: String, level: String, segue2: String) {
        let rejectedAlert = UIAlertController(title: "❌", message: "Wrong Answer", preferredStyle: UIAlertController.Style.alert)
        rejectedAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { _ in
            CATransaction.setCompletionBlock({
                self.addTransitionRiddleAlert(riddle: riddle, answer: answer, viewController: viewController, segue: segue, level: level, segue2: segue)
            })
        }))
        viewController.present(rejectedAlert, animated: true, completion: nil)
    }
    
    private func addGestureAlert(with clue: String, viewController: UIViewController) {
        let gestureAlert = UIAlertController(title: clue, message: "", preferredStyle: UIAlertController.Style.alert)
        gestureAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        viewController.present(gestureAlert, animated: true, completion: nil)
    }
    
}
