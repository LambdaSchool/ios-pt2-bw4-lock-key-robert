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
    @IBOutlet weak var swipeView: UIView!
    
    @IBOutlet var bottomLeftHoldRecognizer: UILongPressGestureRecognizer!
    @IBOutlet var bottomRightHoldRecognizer: UILongPressGestureRecognizer!
    @IBOutlet var swipeRightRecognizer: UISwipeGestureRecognizer!
    
    //MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    //MARK: - Methods
    
    //MARK: - Actions
    
    @IBAction func level4ButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func topLeftButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func topRightButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func bottomLeftHoldComplete(_ sender: Any) {
        
    }
    
    @IBAction func bottomRightHoldComplete(_ sender: Any) {
        
    }
    
    @IBAction func swipeRightComplete(_ sender: Any) {
        
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        
    }
    
    //MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
