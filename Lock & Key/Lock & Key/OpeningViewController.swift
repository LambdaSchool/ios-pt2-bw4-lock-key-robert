//
//  OpeningViewController.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 2/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class OpeningViewController: UIViewController {

    //MARK: - Properties
    
    let sharedController = SharedController()
    
    //MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        sharedController.fadeViewIn(view: self.view)
    }
    
    //MARK: - Actions
    
    @IBAction func playButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        sharedController.segueAfterFadeOut(viewController: self, segue: "playSegue")
    }
    
    @IBAction func trophyButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unlockSegue", sender: self)
    }
    
    @IBAction func progressButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "progressSegue", sender: self)
    }

}
