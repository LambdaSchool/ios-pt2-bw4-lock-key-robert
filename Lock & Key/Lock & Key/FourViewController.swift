//
//  4ViewController.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 2/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class FourViewController: UIViewController {

    //MARK: - Properties
    
    let sharedController = SharedController()
    
    //MARK: - Outlets
    
    @IBOutlet weak var level4Button: UIButton!
    @IBOutlet weak var keysButton: UIButton!
    
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    
    @IBOutlet weak var bottomLeftHoldView: UIView!
    @IBOutlet weak var bottomRightHoldView: UIView!
    
    @IBOutlet weak var middleRightSwipeView: UIView!
    @IBOutlet weak var middleLeftSwipeView: UIView!
    @IBOutlet weak var swipeView: UIView!
    
    @IBOutlet var bottomLeftHoldRecognizer: UILongPressGestureRecognizer!
    @IBOutlet var bottomRightHoldRecognizer: UILongPressGestureRecognizer!
    @IBOutlet var swipeRightRecognizer: UISwipeGestureRecognizer!
    
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
        sharedController.setupButtonBorders(for: topLeftButton)
        sharedController.setupButtonBorders(for: topRightButton)
        
        sharedController.setUpHoldViewBorders(for: bottomLeftHoldView)
        sharedController.setUpHoldViewBorders(for: bottomRightHoldView)
        
        sharedController.setupSwipeViewBorders(for: middleLeftSwipeView)
        sharedController.setupSwipeViewBorders(for: middleRightSwipeView)
        sharedController.setupSwipeViewBorders(for: swipeView)
    }
    
    //MARK: - Actions
    
    @IBAction func level4ButtonTapped(_ sender: Any) {
        sharedController.addRiddleAlert(riddle: "If you havent tried, you're missing out. Come & feel at one with the ocean.", answer: "surfing", clue: "Tap Square", viewController: self, button: topLeftButton, disableButton: nil, gesture: nil, disableGesture: nil, view: nil, segue: "openingSegue", audioPlayer: nil)
    }
    
    @IBAction func topLeftButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: topLeftButton, or: nil)
        sharedController.fadeKeysIn(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "They are more free than we could ever be.", answer: "birds", clue: "Tap Square", viewController: self, button: self.topRightButton, disableButton: self.level4Button, gesture: nil, disableGesture: nil, view: nil, segue: "openingSegue", audioPlayer: nil)
        })
    }
    
    @IBAction func topRightButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: topRightButton, or: nil)
        sharedController.rotateKeysLeft(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "Revered for my beauty, some say I can't be tamed... How fitting.", answer: "ocean", clue: "Hold for Three", viewController: self, button: nil, disableButton: self.topLeftButton, gesture: self.bottomLeftHoldRecognizer, disableGesture: nil, view: self.bottomLeftHoldView, segue: "openingSegue", audioPlayer: nil)
        })
    }
    
    @IBAction func bottomLeftHoldComplete(_ sender: Any) {
        sharedController.shadowOff(for: nil, or: bottomLeftHoldView)
        sharedController.rotateKeysDown(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "Soaring through the air on a daily basis, I'm an iconic symbol where I reside.", answer: "bald eagle", clue: "Hold for Three", viewController: self, button: nil, disableButton: self.topRightButton, gesture: self.bottomRightHoldRecognizer, disableGesture: nil, view: self.bottomRightHoldView, segue: "openingSegue", audioPlayer: nil)
        })
    }
    
    @IBAction func bottomRightHoldComplete(_ sender: Any) {
        sharedController.shadowOff(for: nil, or: bottomRightHoldView)
        sharedController.rotateKeysRight(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "Constantly changing like the water, I'm a bit more breezy.", answer: "wind", clue: "Swipe Right", viewController: self, button: nil, disableButton: nil, gesture: self.swipeRightRecognizer, disableGesture: self.bottomLeftHoldRecognizer, view: self.swipeView, segue: "openingSegue", audioPlayer: nil)
        })
    }
    
    @IBAction func swipeRightComplete(_ sender: Any) {
        sharedController.shadowOff(for: nil, or: swipeView)
        sharedController.rotateKeysUp(for: keysButton)
        
        UserDefaults.standard.set(true, forKey: "isOn5")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addTransitionRiddleAlert(riddle: "What is the theme of this level?", answer: "freedom", viewController: self, segue: "5Segue", level: "4", homeSegue: "openingSegue", disableButton: nil, disableGesture: self.bottomRightHoldRecognizer)
        })
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        sharedController.segueAfterFadeOut(viewController: self, segue: "openingSegue")
    }

}
