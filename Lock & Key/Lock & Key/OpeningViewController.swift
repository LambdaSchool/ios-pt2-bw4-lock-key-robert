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
    
    var on1: Bool = false
    var on2: Bool = false
    var on3: Bool = false
    var on4: Bool = false
    var on5: Bool = false
    var on6: Bool = false
    var on7: Bool = false
    
    //MARK: - Methods
    
    private func onCheck() {
        if on1 == true {
            self.performSegue(withIdentifier: "playSegue", sender: self)
        } else if on2 == true {
            self.performSegue(withIdentifier: "2Segue", sender: self)
        } else if on3 == true {
            self.performSegue(withIdentifier: "3Segue", sender: self)
        } else if on4 == true {
            self.performSegue(withIdentifier: "4Segue", sender: self)
        } else if on5 == true {
            self.performSegue(withIdentifier: "5Segue", sender: self)
        } else if on6 == true {
            self.performSegue(withIdentifier: "6Segue", sender: self)
        } else if on7 == true {
            self.performSegue(withIdentifier: "7Segue", sender: self)
        }
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
