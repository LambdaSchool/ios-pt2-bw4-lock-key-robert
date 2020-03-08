//
//  6ViewController.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 2/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class SixViewController: UIViewController {

    //MARK: - Properties
    
    let sharedController = SharedController()
    
    //MARK: - Outlets
    
    @IBOutlet weak var level6Button: UIButton!
    @IBOutlet weak var keysButton: UIButton!
    
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    @IBOutlet weak var middleLeftSwipeView: UIView!
    @IBOutlet weak var middleRightSwipeView: UIView!
    
    @IBOutlet weak var topHoldView: UIView!
    @IBOutlet weak var topRightHoldView: UIView!
    @IBOutlet weak var topLeftHoldView: UIView!
    
    @IBOutlet var holdRecognizer: UILongPressGestureRecognizer!
    @IBOutlet var middleLeftSwipeDownRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var middleRightSwipeUpRecognizer: UISwipeGestureRecognizer!
    
    //MARK: - Views
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        bordersOn()
    }
    
    //MARK: - Methods
    
    private func bordersOn() {
        sharedController.setupButtonBorders(for: bottomLeftButton)
        sharedController.setupButtonBorders(for: bottomRightButton)
        
        sharedController.setupSwipeViewBorders(for: middleLeftSwipeView)
        sharedController.setupSwipeViewBorders(for: middleRightSwipeView)
        
        sharedController.setUpHoldViewBorders(for: topHoldView)
        sharedController.setUpHoldViewBorders(for: topRightHoldView)
        sharedController.setUpHoldViewBorders(for: topLeftHoldView)
    }
    
    //MARK: - Actions
    
    @IBAction func level6ButtonTapped(_ sender: Any) {
        sharedController.addRiddleAlert(riddle: "With simple supplies, i could be anything. However, most children just call me this.", answer: "fort", clue: "Tap Square", viewController: self, button: bottomLeftButton, disableButton: nil, gesture: nil, disableGesture: nil, view: nil, segue: "openingSegue", audioPlayer: nil)
    }

    @IBAction func bottomLeftButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: bottomLeftButton, or: nil)
        sharedController.fadeKeysIn(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "I wear many faces. If i wear the right face however, even you wouldn't be able to resist me.", answer: "music", clue: "Tap Square", viewController: self, button: self.bottomRightButton, disableButton: self.level6Button, gesture: nil, disableGesture: nil, view: nil, segue: "openingSegue", audioPlayer: nil)
        })
    }
    
    @IBAction func bottomRightButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: bottomRightButton, or: nil)
        sharedController.rotateKeysLeft(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "To be or not to be.", answer: "question", clue: "Swipe Down", viewController: self, button: nil, disableButton: self.bottomLeftButton, gesture: self.middleLeftSwipeDownRecognizer, disableGesture: nil, view: self.middleLeftSwipeView, segue: "openingSegue", audioPlayer: nil)
        })
    }
    
    @IBAction func middleLeftSwipeDownComplete(_ sender: Any) {
        if middleLeftSwipeDownRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: middleLeftSwipeView)
            sharedController.rotateKeysDown(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.sharedController.addRiddleAlert(riddle: "Where the skies are blue and the weather's warm, I am passed around from mouth to mouth.", answer: "aloha", clue: "Swipe Up", viewController: self, button: nil, disableButton: self.bottomRightButton, gesture: self.middleRightSwipeUpRecognizer, disableGesture: nil, view: self.middleRightSwipeView, segue: "openingSegue", audioPlayer: nil)
            })
        }
    }
    
    @IBAction func middleRightSwipeUpComplete(_ sender: Any) {
        if middleRightSwipeUpRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: middleRightSwipeView)
            sharedController.rotateKeysRight(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.sharedController.addRiddleAlert(riddle: "We work as a unit. If one of us fails, the others only get stronger.", answer: "senses", clue: "Hold for Three", viewController: self, button: nil, disableButton: nil, gesture: self.holdRecognizer, disableGesture: self.middleLeftSwipeDownRecognizer, view: self.topHoldView, segue: "openingSegue", audioPlayer: nil)
            })
        }
        
    }
    
    @IBAction func holdComplete(_ sender: Any) {
        if holdRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: topHoldView)
            sharedController.rotateKeysUp(for: keysButton)
            
            UserDefaults.standard.set(true, forKey: "isOn7")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.sharedController.addTransitionRiddleAlert(riddle: "Through the beatings, I stand strong... for this is what I live for. What am I?", answer: "drums", viewController: self, segue: "7Segue", level: "6", homeSegue: "openingSegue", disableButton: nil, disableGesture: self.middleRightSwipeUpRecognizer)
            })
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        
        sharedController.segueAfterFadeOut(viewController: self, segue: "openingSegue")
    }
}
