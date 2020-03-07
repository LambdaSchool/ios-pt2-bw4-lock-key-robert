//
//  7ViewController.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 2/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class SevenViewController: UIViewController {

    //MARK: - Properties
    
    let sharedController = SharedController()
    
    //MARK: - Outlets
    
    @IBOutlet weak var level7Button: UIButton!
    @IBOutlet weak var keysButton: UIButton!
    
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    
    
    @IBOutlet weak var holdGestureView: UIView!
    @IBOutlet var holdRecognizer: UILongPressGestureRecognizer!
    
    @IBOutlet weak var middleLeftSwipeView: UIView!
    @IBOutlet weak var middleRightButton: UIButton!
    
    //MARK: - Views
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        UIApplication.shared.isIdleTimerDisabled = true

        bordersOn()
    }
    
    //MARK: - Methods
    
    private func bordersOn() {
        sharedController.setupButtonBorders(for: topLeftButton)
        sharedController.setupButtonBorders(for: bottomRightButton)
        sharedController.setupButtonBorders(for: topRightButton)
        sharedController.setupButtonBorders(for: bottomLeftButton)
        sharedController.setupButtonBorders(for: middleRightButton)
        
        sharedController.setupSwipeViewBorders(for: middleLeftSwipeView)
        sharedController.setUpHoldViewBorders(for: holdGestureView)
    }
    
    //MARK: - Actions
    
    @IBAction func level7ButtonTapped(_ sender: Any) {
        sharedController.addRiddleAlert(riddle: "My legend precedes me. Like the crack of a whip you’ll be shocked to see me", answer: "lightning", clue: "Tap Square", viewController: self, button: topLeftButton, disableButton: nil, gesture: nil, disableGesture: nil, view: nil, segue: "openingSegue", audioPlayer: nil)
    }
    
    @IBAction func topLeftButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: topLeftButton, or: nil)
        sharedController.fadeKeysIn(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "I allude most, but once i'm found, i'm all you need.", answer: "happiness", clue: "Tap Square", viewController: self, button: self.bottomRightButton, disableButton: self.level7Button, gesture: nil, disableGesture: nil, view: nil, segue: "openingSegue", audioPlayer: nil)
        })
    }
    
    @IBAction func bottomRightButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: bottomRightButton, or: nil)
        sharedController.rotateKeysLeft(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "Beasts to the left and the right... Akin this game, only the bold survive and leave with nothing but a diamond in the rough. What am i?", answer: "rodeo", clue: "Tap Square", viewController: self, button: self.topRightButton, disableButton: self.topLeftButton, gesture: nil, disableGesture: nil, view: nil, segue: "openingSegue", audioPlayer: nil)
        })
    }
    
    @IBAction func topRightButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: topRightButton, or: nil)
        sharedController.rotateKeysDown(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "Why is a raven like a writing desk?", answer: "it isn't", clue: "Tap Square", viewController: self, button: self.bottomLeftButton, disableButton: self.bottomRightButton, gesture: nil, disableGesture: nil, view: nil, segue: "openingSegue", audioPlayer: nil)
        })
    }
    
    @IBAction func bottomLeftButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: bottomLeftButton, or: nil)
        sharedController.rotateKeysRight(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.sharedController.addRiddleAlert(riddle: "It's a rock through a window. It's a riot in the street. It's a rebel revolution that's fighting for peace.", answer: "rock and roll", clue: "Hold for Five", viewController: self, button: nil, disableButton: self.topRightButton, gesture: self.holdRecognizer, disableGesture: nil, view: self.holdGestureView, segue: "openingSegue", audioPlayer: nil)
        })
    }
    
    @IBAction func holdComplete(_ sender: Any) {
        if holdRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: holdGestureView)
            sharedController.rotateKeysUp(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.sharedController.addTransitionRiddleAlert(riddle: "Through the ages, I sang my siren song and men came flocking...but to no avail.", answer: "gold", viewController: self, segue: "finishSegue", level: "7", homeSegue: "openingSegue", disableButton: self.bottomLeftButton, disableGesture: nil)
            })
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        
        sharedController.segueAfterFadeOut(viewController: self, segue: "openingSegue")
    }
}
