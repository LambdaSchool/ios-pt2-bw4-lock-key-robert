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
    
    @IBOutlet var holdRecognizer: UILongPressGestureRecognizer!
    @IBOutlet var middleLeftSwipeDownRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var middleRightSwipeUpRecognizer: UISwipeGestureRecognizer!
    
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
        sharedController.setupButtonBorders(for: bottomLeftButton)
        sharedController.setupButtonBorders(for: bottomRightButton)
        
        sharedController.setupSwipeViewBorders(for: middleLeftSwipeView)
        sharedController.setupSwipeViewBorders(for: middleRightSwipeView)
        
        sharedController.setUpHoldViewBorders(for: topHoldView)
    }
    
    //MARK: - Actions
    
    @IBAction func level6ButtonTapped(_ sender: Any) {
        sharedController.addRiddleAlert(riddle: "", answer: "", clue: "Tap", viewController: self, button: bottomLeftButton, gesture: nil, view: nil, segue: "openingSegue")
    }

    @IBAction func bottomLeftButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: bottomLeftButton, or: nil)
        sharedController.fadeKeysIn(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "", answer: "", clue: "Tap", viewController: self, button: self.bottomRightButton, gesture: nil, view: nil, segue: "openingSegue")
        })
    }
    
    @IBAction func bottomRightButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: bottomRightButton, or: nil)
        sharedController.rotateKeysLeft(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "", answer: "", clue: "Swipe Down", viewController: self, button: nil, gesture: self.middleLeftSwipeDownRecognizer, view: self.middleLeftSwipeView, segue: "openingSegue")
        })
    }
    
    @IBAction func middleLeftSwipeDownComplete(_ sender: Any) {
        if middleLeftSwipeDownRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: middleLeftSwipeView)
            sharedController.rotateKeysDown(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.sharedController.addRiddleAlert(riddle: "", answer: "", clue: "Swipe Up", viewController: self, button: nil, gesture: self.middleRightSwipeUpRecognizer, view: self.middleRightSwipeView, segue: "openingSegue")
            })
        }
    }
    
    @IBAction func middleRightSwipeUpComplete(_ sender: Any) {
        if middleRightSwipeUpRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: middleRightSwipeView)
            sharedController.rotateKeysRight(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.sharedController.addRiddleAlert(riddle: "", answer: "", clue: "Hold for Three", viewController: self, button: nil, gesture: self.holdRecognizer, view: self.topHoldView, segue: "openingSegue")
            })
        }
        
    }
    
    @IBAction func holdComplete(_ sender: Any) {
        if holdRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: topHoldView)
            sharedController.rotateKeysUp(for: keysButton)
            
            UserDefaults.standard.set(true, forKey: "isOn7")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.sharedController.addTransitionRiddleAlert(riddle: "", answer: "", viewController: self, segue: "7Segue", level: "6", homeSegue: "openingSegue")
            })
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        
        sharedController.segueAfterFadeOut(viewController: self, segue: "openingSegue")
    }
}
