//
//  3ViewController.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 2/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class ThreeViewController: UIViewController {

    //MARK: - Properties
    
    let sharedController = SharedController()
    
    //MARK: - Outlets
    
    @IBOutlet weak var level3Button: UIButton!
    @IBOutlet weak var keysButton: UIButton!

    @IBOutlet weak var topRightHoldView: UIView!
    @IBOutlet weak var bottomLeftHoldView: UIView!
    @IBOutlet weak var bottomMiddleHoldView: UIView!
    @IBOutlet weak var bottomRightHoldView: UIView!
    @IBOutlet weak var topLeftHoldView: UIView!
    

    @IBOutlet var topRightHold: UILongPressGestureRecognizer!
    @IBOutlet var bottomLeftHold: UILongPressGestureRecognizer!
    @IBOutlet var bottomMiddleHold: UILongPressGestureRecognizer!
    @IBOutlet var bottomRightHold: UILongPressGestureRecognizer!
    @IBOutlet var topLeftHold: UILongPressGestureRecognizer!
    
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
        sharedController.setUpHoldViewBorders(for: topRightHoldView)
        sharedController.setUpHoldViewBorders(for: bottomLeftHoldView)
        sharedController.setUpHoldViewBorders(for: bottomMiddleHoldView)
        sharedController.setUpHoldViewBorders(for: bottomRightHoldView)
        sharedController.setUpHoldViewBorders(for: topLeftHoldView)
    }
    
    //MARK: - Actions
    
    @IBAction func level3ButtonTapped(_ sender: Any) {
        sharedController.addRiddleAlert(riddle: "With fragrance & color a plenty, I never fail to bring a smile to her face.", answer: "flowers", clue: "Hold for Three", viewController: self, button: nil, gesture: topRightHold, view: topRightHoldView, segue: "openingSegue", audioPlayer: nil)
    }
    
    @IBAction func topRightHoldComplete(_ sender: Any) {
        if topRightHold.state == .ended {
            sharedController.shadowOff(for: nil, or: topRightHoldView)
            sharedController.fadeKeysIn(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                self.sharedController.addRiddleAlert(riddle: "The French speak this language so well, they named Paris after me.", answer: "romance", clue: "Hold for Three", viewController: self, button: nil, gesture: self.bottomLeftHold, view: self.bottomLeftHoldView, segue: "openingSegue", audioPlayer: nil)
            })
        }
    }
    
    @IBAction func bottomLeftHoldComplete(_ sender: Any) {
        if bottomLeftHold.state == .ended {
            sharedController.shadowOff(for: nil, or: bottomLeftHoldView)
            sharedController.rotateKeysLeft(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                self.sharedController.addRiddleAlert(riddle: "Listen to me, and you'll never go wrong.", answer: "heart", clue: "Hold for Three", viewController: self, button: nil, gesture: self.bottomMiddleHold, view: self.bottomMiddleHoldView, segue: "openingSegue", audioPlayer: nil)
            })
        }
    }
    
    @IBAction func bottomMiddleHoldComplete(_ sender: Any) {
        if bottomMiddleHold.state == .ended {
            sharedController.shadowOff(for: nil, or: bottomMiddleHoldView)
            sharedController.rotateKeysDown(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                self.sharedController.addRiddleAlert(riddle: "As smooth as a shot of whiskey, none wrote me better than William.", answer: "poem", clue: "Hold for Three", viewController: self, button: nil, gesture: self.bottomRightHold, view: self.bottomRightHoldView, segue: "openingSegue", audioPlayer: nil)
            })
        }
    }
    
    @IBAction func bottomRightHoldComplete(_ sender: Any) {
        if bottomRightHold.state == .ended {
            sharedController.shadowOff(for: nil, or: bottomRightHoldView)
            sharedController.rotateKeysRight(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                self.sharedController.addRiddleAlert(riddle: "The key to a shallow woman's heart.", answer: "diamonds", clue: "Hold for Three", viewController: self, button: nil, gesture: self.topLeftHold, view: self.topLeftHoldView, segue: "openingSegue", audioPlayer: nil)
            })
        }
    }
    
    @IBAction func topLeftHoldComplete(_ sender: Any) {
        if topLeftHold.state == .ended {
            sharedController.shadowOff(for: nil, or: topLeftHoldView)
            sharedController.rotateKeysUp(for: keysButton)
            
            UserDefaults.standard.set(true, forKey: "isOn4")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                self.sharedController.addTransitionRiddleAlert(riddle: "What is the theme of this level?", answer: "love", viewController: self, segue: "4Segue", level: "3", homeSegue: "openingSegue")
            })
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        
        sharedController.segueAfterFadeOut(viewController: self, segue: "openingSegue")
    }
}
