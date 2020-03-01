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
        
        
    }
    
    @IBAction func swipeLeftGestureCompleted(_ sender: Any) {
        sharedController.fadeKeysIn(for: keysButton)
    }
    
    @IBAction func swipeRightGestureCompleted(_ sender: Any) {
        sharedController.rotateKeysLeft(for: keysButton)
    }
    
    @IBAction func swipeDownGestureCompleted(_ sender: Any) {
        sharedController.rotateKeysDown(for: keysButton)
    }
    
    @IBAction func swipeUpGestureCompleted(_ sender: Any) {
        sharedController.rotateKeysRight(for: keysButton)
    }
    
    @IBAction func swipeLeftTwoGestureCompleted(_ sender: Any) {
        sharedController.rotateKeysUp(for: keysButton)
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        
        sharedController.segueAfterFadeOut(viewController: self, segue: "openingSegue")
    }
}
