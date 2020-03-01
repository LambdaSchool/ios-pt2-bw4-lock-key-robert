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
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var keysButton: UIButton!
    
    //MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        sharedController.addRiddleAlert(riddle: "", answer: "", clue: "", viewController: self, button: nil, gesture: swipeLeftGestureRecognizer, segue: "openingSegue")
    }
    
    @IBAction func swipeLeftGestureCompleted(_ sender: Any) {
        if swipeLeftGestureRecognizer.state == .ended {
            sharedController.fadeKeysIn(for: keysButton)
            
            sharedController.addRiddleAlert(riddle: "", answer: "", clue: "", viewController: self, button: nil, gesture: swipeRightGestureRecognizer, segue: "openingSegue")
        }
    }
    
    @IBAction func swipeRightGestureCompleted(_ sender: Any) {
        if swipeRightGestureRecognizer.state == .ended {
            sharedController.rotateKeysLeft(for: keysButton)
            
            sharedController.addRiddleAlert(riddle: "", answer: "", clue: "", viewController: self, button: nil, gesture: swipeDownGestureRecognizer, segue: "openingSegue")
        }
    }
    
    @IBAction func swipeDownGestureCompleted(_ sender: Any) {
        if swipeDownGestureRecognizer.state == .ended {
            sharedController.rotateKeysDown(for: keysButton)
            
            sharedController.addRiddleAlert(riddle: "", answer: "", clue: "", viewController: self, button: nil, gesture: swipeUpGestureRecognizer, segue: "openingSegue")
        }
    }
    
    @IBAction func swipeUpGestureCompleted(_ sender: Any) {
        if swipeUpGestureRecognizer.state == .ended {
            sharedController.rotateKeysRight(for: keysButton)
            
            sharedController.addRiddleAlert(riddle: "", answer: "", clue: "", viewController: self, button: nil, gesture: swipeLeftTwoGestureRecognizer, segue: "openingSegue")
        }
    }
    
    @IBAction func swipeLeftTwoGestureCompleted(_ sender: Any) {
        if swipeLeftTwoGestureRecognizer.state == .ended {
            sharedController.rotateKeysUp(for: keysButton)
            
            sharedController.addTransitionRiddleAlert(riddle: "", answer: "", viewController: self, segue: "3Segue", level: "2", homeSegue: "openingSegue")
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        
        sharedController.segueAfterFadeOut(viewController: self, segue: "openingSegue")
    }
}
