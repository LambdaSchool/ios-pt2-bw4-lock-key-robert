//
//  5ViewController.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 2/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class FiveViewController: UIViewController {

    //MARK: - Properties
    
    let sharedController = SharedController()
    
    //MARK: - Outlets
    
    @IBOutlet weak var level5Button: UIButton!
    @IBOutlet weak var keysButton: UIButton!
    
    @IBOutlet weak var bottomSwipeView: UIView!
    @IBOutlet weak var topSwipeView: UIView!
    @IBOutlet weak var middleSwipeView: UIView!
    
    @IBOutlet weak var topLeftHoldView: UIView!
    @IBOutlet weak var topRightHoldView: UIView!
    @IBOutlet weak var bottomRightHoldView: UIView!
    @IBOutlet weak var bottomLeftHoldView: UIView!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet var topLeftHoldRecognizer: UILongPressGestureRecognizer!
    @IBOutlet var topRightHoldRecognizer: UILongPressGestureRecognizer!
    @IBOutlet var bottomRightHoldRecognizer: UILongPressGestureRecognizer!
    @IBOutlet var bottomLeftHoldRecognizer: UILongPressGestureRecognizer!
    @IBOutlet var middleSwipeRecognizer: UISwipeGestureRecognizer!
    
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
        sharedController.setupSwipeViewBorders(for: topSwipeView)
        sharedController.setupSwipeViewBorders(for: middleSwipeView)
        sharedController.setupSwipeViewBorders(for: bottomSwipeView)
        
        sharedController.setUpHoldViewBorders(for: topLeftHoldView)
        sharedController.setUpHoldViewBorders(for: topRightHoldView)
        sharedController.setUpHoldViewBorders(for: bottomRightHoldView)
        sharedController.setUpHoldViewBorders(for: bottomLeftHoldView)
        
        sharedController.setupButtonBorders(for: leftButton)
        sharedController.setupButtonBorders(for: rightButton)
    }
    
    //MARK: - Actions
    
    @IBAction func level5ButtonTapped(_ sender: Any) {
        sharedController.addRiddleAlert(riddle: "'It's just a shot away'", answer: "gimme shelter", clue: "Hold for Three", viewController: self, button: nil, gesture: topLeftHoldRecognizer, view: topLeftHoldView, segue: "openingSegue")
    }
    
    @IBAction func topLeftHoldComplete(_ sender: Any) {
        if topLeftHoldRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: topLeftHoldView)
            sharedController.fadeKeysIn(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.sharedController.addRiddleAlert(riddle: "'The night is my companion & the highway is my home.'", answer: "stone", clue: "Hold for Three", viewController: self, button: nil, gesture: self.topRightHoldRecognizer, view: self.topRightHoldView, segue: "openingSegue")
            })
        }
    }
    
    @IBAction func topRightHoldComplete(_ sender: Any) {
        if topRightHoldRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: topRightHoldView)
            sharedController.rotateKeysLeft(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.sharedController.addRiddleAlert(riddle: "'Like the time they hid that grass from those cops in Tupalo.'", answer: "these boots", clue: "Hold for Three", viewController: self, button: nil, gesture: self.bottomRightHoldRecognizer, view: self.bottomRightHoldView, segue: "openingSegue")
            })
        }
    }
    
    @IBAction func bottomRightHoldComplete(_ sender: Any) {
        if bottomRightHoldRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: bottomRightHoldView)
            sharedController.rotateKeysDown(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.sharedController.addRiddleAlert(riddle: "'Here's a toast to your unknown... You and I are one together.'", answer: "fade away", clue: "Hold for Three", viewController: self, button: nil, gesture: self.bottomLeftHoldRecognizer, view: self.bottomLeftHoldView, segue: "openingSegue")
            })
        }
    }
    
    @IBAction func bottomLeftHoldComplete(_ sender: Any) {
        if bottomLeftHoldRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: bottomLeftHoldView)
            sharedController.rotateKeysRight(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.sharedController.addRiddleAlert(riddle: "'He came on a summer's day bringin' gifts from far away.'", answer: "brandy", clue: "Swipe Right", viewController: self, button: nil, gesture: self.middleSwipeRecognizer, view: self.middleSwipeView, segue: "openingSegue")
            })
        }
    }
    
    @IBAction func middleSwipeComplete(_ sender: Any) {
        if middleSwipeRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: middleSwipeView)
            sharedController.rotateKeysUp(for: keysButton)
            
            if UserDefaults.standard.bool(forKey: "Unlocked") == true {
                UserDefaults.standard.set(true, forKey: "isOn6")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.sharedController.addTransitionRiddleAlert(riddle: "What is the theme of this level?", answer: "music", viewController: self, segue: "6Segue", level: "5", homeSegue: "openingSegue")
                })
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.sharedController.endFreePlayAlert(viewController: self, segue: "openingSegue")
                    
                })
            }
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        
        sharedController.segueAfterFadeOut(viewController: self, segue: "openingSegue")
    }
}
