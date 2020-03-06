//
//  2ViewController.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 2/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {

    //MARK: - Properties
    
    let sharedController = SharedController()
    
    //MARK: - Outlets
    
    @IBOutlet weak var level2Button: UIButton!
    @IBOutlet weak var topMiddleSwipeView: UIView!
    @IBOutlet weak var centerMiddleSwipeView: UIView!
    @IBOutlet weak var middleLeftSwipeView: UIView!
    @IBOutlet weak var middleRightSwipeView: UIView!
    @IBOutlet weak var bottomMiddleSwipeView: UIView!
    
    @IBOutlet var swipeLeftGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var swipeRightGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var swipeDownGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var swipeUpGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var swipeLeftTwoGestureRecognizer: UISwipeGestureRecognizer!
    
    @IBOutlet weak var keysButton: UIButton!
    
    //MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
        self.view.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        sharedController.fadeViewIn(view: self.view)
        bordersOn()
    }
    
    //MARK: - Methods
    
    private func bordersOn() {
        sharedController.setupSwipeViewBorders(for: topMiddleSwipeView)
        sharedController.setupSwipeViewBorders(for: centerMiddleSwipeView)
        sharedController.setupSwipeViewBorders(for: middleLeftSwipeView)
        sharedController.setupSwipeViewBorders(for: middleRightSwipeView)
        sharedController.setupSwipeViewBorders(for: bottomMiddleSwipeView)
    }
    
    //MARK: - Actions
    
    @IBAction func level2ButtonTapped(_ sender: Any) {
        sharedController.addRiddleAlert(riddle: "Silent as the.", answer: "grave", clue: "Swipe Left", viewController: self, button: nil, disableButton: nil, gesture: swipeLeftGestureRecognizer, disableGesture: nil, view: topMiddleSwipeView, segue: "openingSegue", audioPlayer: nil)
    }
    
    @IBAction func swipeLeftGestureCompleted(_ sender: Any) {
        if swipeLeftGestureRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: topMiddleSwipeView)
            sharedController.fadeKeysIn(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                self.sharedController.addRiddleAlert(riddle: "Constantly changing, I am one thing you can always count on running out of.", answer: "time", clue: "Swipe Right", viewController: self, button: nil, disableButton: self.level2Button, gesture: self.swipeRightGestureRecognizer, disableGesture: nil, view: self.centerMiddleSwipeView, segue: "openingSegue", audioPlayer: nil)
            })
        }
    }
    
    @IBAction func swipeRightGestureCompleted(_ sender: Any) {
        if swipeRightGestureRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: centerMiddleSwipeView)
            sharedController.rotateKeysLeft(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                self.sharedController.addRiddleAlert(riddle: "Haunting people for years, I am no more than a home for my eight legged friends.", answer: "cobwebs", clue: "Swipe Down", viewController: self, button: nil, disableButton: nil, gesture: self.swipeDownGestureRecognizer, disableGesture: self.swipeLeftGestureRecognizer, view: self.middleLeftSwipeView, segue: "openingSegue", audioPlayer: nil)
            })
        }
    }
    
    @IBAction func swipeDownGestureCompleted(_ sender: Any) {
        if swipeDownGestureRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: middleLeftSwipeView)
            sharedController.rotateKeysDown(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                self.sharedController.addRiddleAlert(riddle: "I am your final resting place… unless you’re a vampire of course.", answer: "coffin", clue: "Swipe Up", viewController: self, button: nil, disableButton: nil, gesture: self.swipeUpGestureRecognizer, disableGesture: self.swipeRightGestureRecognizer, view: self.middleRightSwipeView, segue: "openingSegue", audioPlayer: nil)
            })
        }
    }
    
    @IBAction func swipeUpGestureCompleted(_ sender: Any) {
        if swipeUpGestureRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: middleRightSwipeView)
            sharedController.rotateKeysRight(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                self.sharedController.addRiddleAlert(riddle: "Scyth in hand, this symbol for death can be quite grim.", answer: "reaper", clue: "Swipe Left", viewController: self, button: nil, disableButton: nil, gesture: self.swipeLeftTwoGestureRecognizer, disableGesture: self.swipeDownGestureRecognizer, view: self.bottomMiddleSwipeView, segue: "openingSegue", audioPlayer: nil)
            })
        }
    }
    
    @IBAction func swipeLeftTwoGestureCompleted(_ sender: Any) {
        if swipeLeftTwoGestureRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: bottomMiddleSwipeView)
            sharedController.rotateKeysUp(for: keysButton)
            
            UserDefaults.standard.set(true, forKey: "isOn3")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                self.sharedController.addTransitionRiddleAlert(riddle: "What is the theme of this level?", answer: "death", viewController: self, segue: "3Segue", level: "2", homeSegue: "openingSegue", disableButton: nil, disableGesture: self.swipeUpGestureRecognizer)
            })
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        
        sharedController.segueAfterFadeOut(viewController: self, segue: "openingSegue")
    }
}
