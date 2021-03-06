//
//  1ViewController.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 2/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {

    //MARK: - Properties
    
    let sharedController = SharedController()
    
    //MARK: - Outlets
    
    @IBOutlet weak var startTextView: UITextView!
    @IBOutlet weak var tapLabel: UILabel!
    @IBOutlet weak var level1Button: UIButton!
    @IBOutlet weak var keysButton: UIButton!
    
    @IBOutlet weak var topMiddleButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    
    //MARK: - Views
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        bordersOn()
        setUpStartTextView()
    }
    
    //MARK: - Methods
    
    private func bordersOn() {
        sharedController.setupButtonBorders(for: topMiddleButton)
        sharedController.setupButtonBorders(for: bottomRightButton)
        sharedController.setupButtonBorders(for: topLeftButton)
        sharedController.setupButtonBorders(for: topRightButton)
        sharedController.setupButtonBorders(for: bottomLeftButton)
    }
    
    private func setUpStartTextView() {
        startTextView.backgroundColor = .clear
        startTextView.textColor = .black
    }
    
    private func fadeStartTextViewOff() {
        UIView.animate(withDuration: 2.0, animations: {
            self.startTextView.alpha = 0
        })
    }
    
    //MARK: - Actions
    
    @IBAction func levelOneButtonTapped(_ sender: Any) {
        fadeStartTextViewOff()
        
        sharedController.addRiddleAlert(riddle: "I'm all around you, living & breathing.", answer: "nature", clue: "Tap Square", viewController: self, button: topMiddleButton, disableButton: nil, gesture: nil, disableGesture: nil, view: nil, segue: "openingSegue", audioPlayer: nil)
    }
    
    @IBAction func topMiddleButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: topMiddleButton, or: nil)
        sharedController.fadeKeysIn(for: keysButton)
        sharedController.fadeLabelInThenOut(label: tapLabel, delay: 1.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.sharedController.addRiddleAlert(riddle: "I am the begining. Through pain, I usher in life.", answer: "birth", clue: "Tap Square", viewController: self, button: self.bottomRightButton, disableButton: self.level1Button, gesture: nil, disableGesture: nil, view: nil, segue: "openingSegue", audioPlayer: nil)
        })
    }
    
    @IBAction func bottomRightButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: bottomRightButton, or: nil)
        sharedController.rotateKeysLeft(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.sharedController.addRiddleAlert(riddle: "Wisdom may be wasted on the old, but I am wasted on the young.", answer: "youth", clue: "Tap Square", viewController: self, button: self.topLeftButton, disableButton: self.topMiddleButton, gesture: nil, disableGesture: nil, view: nil, segue: "openingSegue", audioPlayer: nil)
        })
    }
    
    @IBAction func topLeftButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: topLeftButton, or: nil)
        sharedController.rotateKeysDown(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.sharedController.addRiddleAlert(riddle: "I am the inevitable. Simply come with me when your time comes.", answer: "death", clue: "Tap Square", viewController: self, button: self.topRightButton, disableButton: self.bottomRightButton, gesture: nil, disableGesture: nil, view: nil, segue: "openingSegue", audioPlayer: nil)
        })
    }
    
    @IBAction func topRightButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: topRightButton, or: nil)
        sharedController.rotateKeysRight(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.sharedController.addRiddleAlert(riddle: "Forty days and Forty nights. That’s how long you can go without me.", answer: "food", clue: "Tap Square", viewController: self, button: self.bottomLeftButton, disableButton: self.topLeftButton, gesture: nil, disableGesture: nil, view: nil, segue: "openingSegue", audioPlayer: nil)
        })
    }
    
    @IBAction func bottomLeftButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: bottomLeftButton, or: nil)
        sharedController.rotateKeysUp(for: keysButton)
        
        UserDefaults.standard.set(true, forKey: "isOn2")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.sharedController.addTransitionRiddleAlert(riddle: "What is the theme of this level?", answer: "life", viewController: self, segue: "2Segue", level: "1", homeSegue: "openingSegue", disableButton: self.topRightButton, disableGesture: nil)
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        sharedController.segueAfterFadeOut(viewController: self, segue: "openingSegue")
    }

}
