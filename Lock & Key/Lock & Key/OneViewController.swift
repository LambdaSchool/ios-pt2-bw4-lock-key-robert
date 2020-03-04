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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
        self.view.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        sharedController.fadeViewIn(view: self.view)
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
        
        sharedController.addRiddleAlert(riddle: "I'm all around you, living & breathing. Don't forget to enjoy me every now and then.", answer: "nature", clue: "Tap Square", viewController: self, button: topMiddleButton, gesture: nil, view: nil, segue: "openingSegue")
    }
    
    @IBAction func topMiddleButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: topMiddleButton, or: nil)
        sharedController.fadeKeysIn(for: keysButton)
        sharedController.fadeLabelInThenOut(label: tapLabel, delay: 1.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.sharedController.addRiddleAlert(riddle: "I am the begining. Through pain, I give life.", answer: "birth", clue: "Tap Square", viewController: self, button: self.bottomRightButton, gesture: nil, view: nil, segue: "openingSegue")
        })
    }
    
    @IBAction func bottomRightButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: bottomRightButton, or: nil)
        sharedController.rotateKeysLeft(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.sharedController.addRiddleAlert(riddle: "Wisdom may be wasted on the old, but I am wasted on the young.", answer: "youth", clue: "Tap Square", viewController: self, button: self.topLeftButton, gesture: nil, view: nil, segue: "openingSegue")
        })
    }
    
    @IBAction func topLeftButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: topLeftButton, or: nil)
        sharedController.rotateKeysDown(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.sharedController.addRiddleAlert(riddle: "If you're not trying to have me, what's the point? I make your day brighter every time we get together.", answer: "fun", clue: "Tap Square", viewController: self, button: self.topRightButton, gesture: nil, view: nil, segue: "openingSegue")
        })
    }
    
    @IBAction func topRightButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: topRightButton, or: nil)
        sharedController.rotateKeysRight(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.sharedController.addRiddleAlert(riddle: "A source of sustinance at its core, yet exquisite and delectible at it's best. What am I?", answer: "food", clue: "Tap Square", viewController: self, button: self.bottomLeftButton, gesture: nil, view: nil, segue: "openingSegue")
        })
    }
    
    @IBAction func bottomLeftButtonTapped(_ sender: Any) {
        sharedController.shadowOff(for: bottomLeftButton, or: nil)
        sharedController.rotateKeysUp(for: keysButton)
        
        UserDefaults.standard.set(true, forKey: "isOn2")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.sharedController.addTransitionRiddleAlert(riddle: "I am the inevitable. Theres no need to struggle, simply come with me and see when it's your time.", answer: "death", viewController: self, segue: "2Segue", level: "1", homeSegue: "openingSegue")
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        sharedController.segueAfterFadeOut(viewController: self, segue: "openingSegue")
    }

}
