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
    
    func fadeViewIn(view: UIView) {
        UIView.animate(withDuration: 3.0, animations: {
            view.alpha = 1
        })
    }
    
    func fadeViewOut(view: UIView) {
        UIView.animate(withDuration: 1.5, animations: {
            view.alpha = 0
        })
    }
    
    func fadeLabelInThenOut(label : UILabel, delay: TimeInterval) {
        
        UIView.animate(withDuration: 1.5, animations: { () -> Void in
            label.alpha = 1
        }) { (Bool) -> Void in
            
            UIView.animate(withDuration: 1.5, delay: delay, options: .curveEaseInOut, animations: { () -> Void in
                label.alpha = 0
            },
                           completion: nil)
        }
    }
    
    func shadowOn(for button: UIButton?, or view: UIView?) {
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, animations: {
                //Button
                button?.layer.shadowColor = UIColor.darkGray.cgColor
                button?.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
                button?.layer.shadowOpacity = 1.0
                button?.layer.shadowRadius = 0.0
                button?.layer.masksToBounds = false
                
                //View
                view?.layer.shadowColor = UIColor.darkGray.cgColor
                view?.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
                view?.layer.shadowOpacity = 1.0
                view?.layer.shadowRadius = 0.0
                view?.layer.masksToBounds = false
            })
        }
    }
    
    func shadowOff(for button: UIButton?, or view: UIView?) {
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, animations: {
                //Button
                button?.layer.shadowOpacity = 0.0
                
                //View
                view?.layer.shadowOpacity = 0.0
            })
        }
    }
    
    //MARK: - Riddle Methods
    
    func endFreePlayAlert(viewController: UIViewController, segue: String) {
        
        let freeAlert = UIAlertController(title: "This is the end of the free game!", message: "If you wish to continue, please unlock the final 2 levels", preferredStyle: .alert)
        
        freeAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            viewController.performSegue(withIdentifier: segue, sender: viewController)
        }))
        
        viewController.present(freeAlert, animated: true, completion: nil)
    }
    
    func addRiddleAlert(riddle: String, answer: String, clue: String, viewController: UIViewController, button: UIButton?, gesture: UIGestureRecognizer?, view: UIView?, segue: String) {
        
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
                self.shadowOn(for: button, or: view)
                button?.isEnabled = true
                gesture?.isEnabled = true
            } else {
                CATransaction.setCompletionBlock({
                    self.addRejectedAlert(for: viewController, riddle: riddle, answer: answer, clue: clue, button: button, gesture: gesture, view: view, segue: segue)
                })
            }
        }))
        riddleAlert.addAction(UIAlertAction(title: "Home", style: UIAlertAction.Style.cancel, handler: { _ in
            self.fadeViewOut(view: viewController.view)
            self.segueAfterFadeOut(viewController: viewController, segue: segue)
        }))
        
        viewController.present(riddleAlert, animated: true, completion: nil)
    }
    
    private func addRejectedAlert(for viewController: UIViewController, riddle: String, answer: String, clue: String, button: UIButton?, gesture: UIGestureRecognizer?, view: UIView?, segue: String) {
        let rejectedAlert = UIAlertController(title: "❌", message: "Wrong Answer", preferredStyle: UIAlertController.Style.alert)
        rejectedAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { _ in
            self.addRiddleAlert(riddle: riddle, answer: answer, clue: clue, viewController: viewController, button: button, gesture: gesture, view: view, segue: segue)
        }))
        viewController.present(rejectedAlert, animated: true, completion: nil)
    }
    
    func addTransitionRiddleAlert(riddle: String, answer: String, viewController: UIViewController, segue: String, level: String, homeSegue: String) {
        
        let transitionRiddleAlert = UIAlertController(title: "Level \(level) Complete!", message: riddle, preferredStyle: UIAlertController.Style.alert)
        transitionRiddleAlert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter correct answer:"
        })
        
        transitionRiddleAlert.addAction(UIAlertAction(title: "Submit", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            guard let guess = transitionRiddleAlert.textFields![0].text?.lowercased() else { return }
            
            if guess == answer {
                transitionRiddleAlert.message = ""
                transitionRiddleAlert.dismiss(animated: true, completion: nil)
                self.fadeViewOut(view: viewController.view)
                self.segueAfterFadeOut(viewController: viewController, segue: segue)
            } else {
                self.addRejectedTransitionAlert(for: viewController, riddle: riddle, answer: answer, segue: segue, level: level, segue2: homeSegue)
            }
        }))
        
        transitionRiddleAlert.addAction(UIAlertAction(title: "Home", style: UIAlertAction.Style.cancel, handler: { _ in
            self.fadeViewOut(view: viewController.view)
            self.segueAfterFadeOut(viewController: viewController, segue: homeSegue)
        }))

        viewController.present(transitionRiddleAlert, animated: true, completion: nil)
    }
    
    private func addRejectedTransitionAlert(for viewController: UIViewController, riddle: String, answer: String, segue: String, level: String, segue2: String) {
        let rejectedAlert = UIAlertController(title: "❌", message: "Wrong Answer", preferredStyle: UIAlertController.Style.alert)
        rejectedAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { _ in
            CATransaction.setCompletionBlock({
                self.addTransitionRiddleAlert(riddle: riddle, answer: answer, viewController: viewController, segue: segue, level: level, homeSegue: segue)
            })
        }))
        viewController.present(rejectedAlert, animated: true, completion: nil)
    }
    
    private func addGestureAlert(with clue: String, viewController: UIViewController) {
        let gestureAlert = UIAlertController(title: clue, message: "", preferredStyle: UIAlertController.Style.alert)
        gestureAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        viewController.present(gestureAlert, animated: true, completion: nil)
    }
    
    
    //MARK: - View Methods
    
    func setupButtonBorders(for button: UIButton) {
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 10.0
    }
    
    func setupSwipeViewBorders(for view: UIView) {
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2.0
        view.layer.cornerRadius = 10.0
    }
    
    func setUpHoldViewBorders(for view: UIView) {
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2.0
        view.layer.cornerRadius = 35.0
    }
    
    func toggleButtonAlpha(with button: UIButton) {
        if button.isEnabled {
            button.alpha = 1
        } else {
            button.alpha = 0.5
        }
    }
    
    
    //MARK: - Segue Methods
    
    func segueAfterFadeOut(viewController: UIViewController, segue: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            viewController.performSegue(withIdentifier: segue, sender: viewController)
        })
    }
    
}
