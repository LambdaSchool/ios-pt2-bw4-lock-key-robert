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
    @IBOutlet weak var level1Button: UIButton!
    @IBOutlet weak var keysButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var topMiddleButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    
    //MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        startTextView.backgroundColor = .white
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
        
        sharedController.addRiddleAlert(riddle: "", answer: "", clue: "", viewController: self, button: topMiddleButton, gesture: nil, segue: "openingSegue")
    }
    
    @IBAction func topMiddleButtonTapped(_ sender: Any) {
        sharedController.fadeKeysIn(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.sharedController.addRiddleAlert(riddle: "", answer: "", clue: "", viewController: self, button: self.bottomRightButton, gesture: nil, segue: "openingSegue")
        })
    }
    
    @IBAction func bottomRightButtonTapped(_ sender: Any) {
        sharedController.rotateKeysLeft(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.sharedController.addRiddleAlert(riddle: "", answer: "", clue: "", viewController: self, button: self.topRightButton, gesture: nil, segue: "openingSegue")
        })
    }
    
    @IBAction func topLeftButtonTapped(_ sender: Any) {
        sharedController.rotateKeysDown(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.sharedController.addRiddleAlert(riddle: "", answer: "", clue: "", viewController: self, button: self.topRightButton, gesture: nil, segue: "openingSegue")
        })
    }
    
    @IBAction func topRightButtonTapped(_ sender: Any) {
        sharedController.rotateKeysRight(for: keysButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.sharedController.addRiddleAlert(riddle: "", answer: "", clue: "", viewController: self, button: self.bottomLeftButton, gesture: nil, segue: "openingSegue")
        })
    }
    
    @IBAction func bottomLeftButtonTapped(_ sender: Any) {
        sharedController.rotateKeysUp(for: keysButton)
        
        UserDefaults.standard.set(true, forKey: "isOn2")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.sharedController.addTransitionRiddleAlert(riddle: "", answer: "", viewController: self, segue: "2Segue", level: "1", segue2: "openingSegue")
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        sharedController.segueAfterFadeOut(viewController: self, segue: "openingSegue")
    }

}
