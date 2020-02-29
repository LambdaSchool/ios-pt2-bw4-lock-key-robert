//
//  UnlockViewController.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 2/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit
import StoreKit

class UnlockViewController: UIViewController {

    //MARK: - Properties
    
    let sharedController = SharedController()
    var product: SKProduct?
    
    //MARK: - Outlets
    
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!
    
    //MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchProduct()
        setUpSubviews()
    }
    
    //MARK: - Methods
    
    private func setUpSubviews() {
        sharedController.setupButtonBorders(for: unlockButton)
        sharedController.setupButtonBorders(for: restoreButton)
    }
    
    private func fetchProduct() {
        //Fetch Product & Set.
    }
    
    //MARK: - Actions
    
    @IBAction func unlockButtonTapped(_ sender: Any) {
        //Purchase product
    }
    
    @IBAction func restoreButtonTapped(_ sender: Any) {
        //Restore product
    }
    
}
