//
//  SharedController.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 2/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class SharedController {
    
    //MARK: - Properties
    
    var blackWindow: UIWindow?
    
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
        blackWindow = UIWindow(windowScene: view.window!.windowScene!)
        blackWindow?.backgroundColor = .black
        blackWindow?.alpha = 0
        blackWindow?.makeKeyAndVisible()
        
        UIView.animate(withDuration: 1.5, animations: {
            self.blackWindow?.alpha = 1
        })
    }
    
    func fadeLabelInThenOut(label : UILabel, delay: TimeInterval) {
        
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
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
                button?.layer.shadowColor = UIColor.black.cgColor
                button?.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
                button?.layer.shadowOpacity = 0.8
                button?.layer.shadowRadius = 0.0
                button?.layer.masksToBounds = false
                
                //View
                view?.layer.shadowColor = UIColor.black.cgColor
                view?.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
                view?.layer.shadowOpacity = 0.8
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
        
        let freeAlert = UIAlertController(title: "This is the End of the Free Game", message: "Please unlock bonus levels", preferredStyle: .alert)
        
        freeAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.fadeViewOut(view: viewController.view)
            self.segueAfterFadeOut(viewController: viewController, segue: segue)
        }))
        
        viewController.present(freeAlert, animated: true, completion: nil)
        
        if viewController.traitCollection.userInterfaceStyle == .dark {
            freeAlert.view.tintColor = .white
        } else {
            freeAlert.view.tintColor = .black
        }
    }
    
    func addRiddleAlert(riddle: String, answer: String, clue: String, viewController: UIViewController, button: UIButton?, disableButton: UIButton?, gesture: UIGestureRecognizer?, disableGesture: UIGestureRecognizer?, view: UIView?, segue: String, audioPlayer: AVAudioPlayer?) {
        
        let riddleAlert = UIAlertController(title: riddle, message: "", preferredStyle: UIAlertController.Style.alert)
        
        disableButton?.isEnabled = false
        disableGesture?.isEnabled = false
        
        if audioPlayer == nil {
            riddleAlert.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "Enter correct answer:"
            })
        } else {
            riddleAlert.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "Enter song name:"
            })
        }
        
        riddleAlert.addAction(UIAlertAction(title: "Submit", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            guard let guess = riddleAlert.textFields![0].text?.lowercased() else { return }
            
            if guess == answer {
                riddleAlert.message = ""
                riddleAlert.dismiss(animated: true, completion: nil)
                self.addGestureAlert(with: clue, viewController: viewController, audioPlayer: audioPlayer)
                self.shadowOn(for: button, or: view)
                button?.isEnabled = true
                gesture?.isEnabled = true
            } else {
                CATransaction.setCompletionBlock({
                    self.addRejectedAlert(for: viewController, riddle: riddle, answer: answer, clue: clue, button: button, disableButton: disableButton, gesture: gesture, disableGesture: disableGesture, view: view, segue: segue, audioPlayer: audioPlayer)
                })
            }
        }))
        riddleAlert.addAction(UIAlertAction(title: "Home", style: UIAlertAction.Style.cancel, handler: { _ in
            audioPlayer?.stop()
            self.fadeViewOut(view: viewController.view)
            self.segueAfterFadeOut(viewController: viewController, segue: segue)
        }))
        
        viewController.present(riddleAlert, animated: true, completion: nil)
        
        if viewController.traitCollection.userInterfaceStyle == .dark {
            riddleAlert.view.tintColor = .white
        } else {
            riddleAlert.view.tintColor = .black
        }
    }
    
    private func addRejectedAlert(for viewController: UIViewController, riddle: String, answer: String, clue: String, button: UIButton?, disableButton: UIButton?, gesture: UIGestureRecognizer?, disableGesture: UIGestureRecognizer?, view: UIView?, segue: String, audioPlayer: AVAudioPlayer?) {
        let rejectedAlert = UIAlertController(title: "Wrong Answer", message: "please try again", preferredStyle: UIAlertController.Style.alert)
        rejectedAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { _ in
            self.addRiddleAlert(riddle: riddle, answer: answer, clue: clue, viewController: viewController, button: button, disableButton: disableButton, gesture: gesture, disableGesture: disableGesture, view: view, segue: segue, audioPlayer: audioPlayer)
        }))
        viewController.present(rejectedAlert, animated: true, completion: nil)
        
        if viewController.traitCollection.userInterfaceStyle == .dark {
            rejectedAlert.view.tintColor = .white
        } else {
            rejectedAlert.view.tintColor = .black
        }
    }
    
    func addTransitionRiddleAlert(riddle: String, answer: String, viewController: UIViewController, segue: String, level: String, homeSegue: String, disableButton: UIButton?, disableGesture: UIGestureRecognizer?) {
        
        let transitionRiddleAlert = UIAlertController(title: "Level \(level) Complete!", message: riddle, preferredStyle: UIAlertController.Style.alert)
        
        disableButton?.isEnabled = false
        disableGesture?.isEnabled = false
        
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
                self.addRejectedTransitionAlert(for: viewController, riddle: riddle, answer: answer, segue: segue, level: level, segue2: homeSegue, disableButton: disableButton, disableGesture: disableGesture)
            }
        }))
        
        transitionRiddleAlert.addAction(UIAlertAction(title: "Home", style: UIAlertAction.Style.cancel, handler: { _ in
            self.fadeViewOut(view: viewController.view)
            self.segueAfterFadeOut(viewController: viewController, segue: homeSegue)
        }))

        viewController.present(transitionRiddleAlert, animated: true, completion: nil)
        
        
        if viewController.traitCollection.userInterfaceStyle == .dark {
            transitionRiddleAlert.view.tintColor = .white
        } else {
            transitionRiddleAlert.view.tintColor = .black
        }
    }
    
    func addLevel5TransitionRiddleAlert(riddle: String, answer: String, viewController: UIViewController, segue: String, level: String, homeSegue: String, disableButton: UIButton?, disableGesture: UIGestureRecognizer?) {
        
        let transitionRiddleAlert = UIAlertController(title: "Level \(level) Complete!", message: riddle, preferredStyle: UIAlertController.Style.alert)
        transitionRiddleAlert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter correct answer:"
        })
        
        transitionRiddleAlert.addAction(UIAlertAction(title: "Submit", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            guard let guess = transitionRiddleAlert.textFields![0].text?.lowercased() else { return }
            
            UserDefaults.standard.set(true, forKey: "is5Complete")
            
            if guess == answer {
                if UserDefaults.standard.bool(forKey: "Unlocked") == true {
                    UserDefaults.standard.set(true, forKey: "isOn6")
                    transitionRiddleAlert.message = ""
                    transitionRiddleAlert.dismiss(animated: true, completion: nil)
                    self.fadeViewOut(view: viewController.view)
                    self.segueAfterFadeOut(viewController: viewController, segue: segue)
                } else {
                    self.endFreePlayAlert(viewController: viewController, segue: homeSegue)
                }
            } else {
                self.addRejectedTransitionAlert(for: viewController, riddle: riddle, answer: answer, segue: segue, level: level, segue2: homeSegue, disableButton: disableButton, disableGesture: disableGesture)
            }
        }))
        
        transitionRiddleAlert.addAction(UIAlertAction(title: "Home", style: UIAlertAction.Style.cancel, handler: { _ in
            self.fadeViewOut(view: viewController.view)
            self.segueAfterFadeOut(viewController: viewController, segue: homeSegue)
        }))

        viewController.present(transitionRiddleAlert, animated: true, completion: nil)
        
        
        if viewController.traitCollection.userInterfaceStyle == .dark {
            transitionRiddleAlert.view.tintColor = .white
        } else {
            transitionRiddleAlert.view.tintColor = .black
        }
    }
    
    private func addRejectedTransitionAlert(for viewController: UIViewController, riddle: String, answer: String, segue: String, level: String, segue2: String, disableButton: UIButton?, disableGesture: UIGestureRecognizer?) {
        let rejectedAlert = UIAlertController(title: "Wrong Answer", message: "please try again", preferredStyle: UIAlertController.Style.alert)
        rejectedAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { _ in
            CATransaction.setCompletionBlock({
                self.addTransitionRiddleAlert(riddle: riddle, answer: answer, viewController: viewController, segue: segue, level: level, homeSegue: segue, disableButton: disableButton, disableGesture: disableGesture)
            })
        }))
        viewController.present(rejectedAlert, animated: true, completion: nil)
        
        if viewController.traitCollection.userInterfaceStyle == .dark {
            rejectedAlert.view.tintColor = .white
        } else {
            rejectedAlert.view.tintColor = .black
        }
    }
    
    private func addGestureAlert(with clue: String, viewController: UIViewController, audioPlayer: AVAudioPlayer?) {
        let gestureAlert = UIAlertController(title: clue, message: "", preferredStyle: UIAlertController.Style.alert)
        gestureAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        viewController.present(gestureAlert, animated: true, completion: nil)
        if viewController.traitCollection.userInterfaceStyle == .dark {
            gestureAlert.view.tintColor = .white
        } else {
            gestureAlert.view.tintColor = .black
        }
        audioPlayer?.stop()
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
            
            UIView.animate(withDuration: 1.5, animations: {
                self.blackWindow?.alpha = 0
            }) { (_) in
                self.blackWindow?.isHidden = true
                self.blackWindow = nil
                viewController.view.window?.makeKeyAndVisible()
            }
        })
    }
    
}
