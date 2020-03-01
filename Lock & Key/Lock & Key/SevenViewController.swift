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
    var didCompleteTaps: Bool = false
    var didCompletePress: Bool = false
    
    //MARK: - Outlets
    
    @IBOutlet weak var level7Button: UIButton!
    @IBOutlet weak var keysButton: UIButton!
    
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    
    @IBOutlet weak var customGestureView: UIView!
    @IBOutlet var customGestureRecognizer: UIGestureRecognizer!
    
    @IBOutlet weak var middleLeftSwipeView: UIView!
    @IBOutlet weak var middleRightButton: UIButton!
    
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
        sharedController.setupButtonBorders(for: bottomRightButton)
        sharedController.setupButtonBorders(for: topRightButton)
        sharedController.setupButtonBorders(for: bottomLeftButton)
        sharedController.setupButtonBorders(for: middleRightButton)
        
        sharedController.setupSwipeViewBorders(for: middleLeftSwipeView)
        sharedController.setupSwipeViewBorders(for: customGestureView)
    }
    
    //MARK: - Actions
    
    @IBAction func level7ButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func topLeftButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func bottomRightButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func topRightButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func bottomLeftButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func middleRightButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func customGestureComplete(_ sender: Any) {
        
    }
    
    @IBAction func keysButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        
        sharedController.segueAfterFadeOut(viewController: self, segue: "openingSegue")
    }
}
