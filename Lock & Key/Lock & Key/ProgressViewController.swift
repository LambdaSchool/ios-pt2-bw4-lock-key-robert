//
//  ProgressViewController.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 2/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {

    //MARK: - Properties
    
    let sharedController = SharedController()
    
    //MARK: - Outlets
    
    @IBOutlet weak var level1Label: UILabel!
    @IBOutlet weak var level2Label: UILabel!
    @IBOutlet weak var level3Label: UILabel!
    @IBOutlet weak var level4Label: UILabel!
    @IBOutlet weak var level5Label: UILabel!
    
    @IBOutlet weak var level1Button: UIButton!
    @IBOutlet weak var level2Button: UIButton!
    @IBOutlet weak var level3Button: UIButton!
    @IBOutlet weak var level4Button: UIButton!
    @IBOutlet weak var level5Button: UIButton!
    @IBOutlet weak var level6Button: UIButton!
    @IBOutlet weak var level7Button: UIButton!
    
    //MARK: - Views
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setEnabled()
        alphaCheck()
        checkUnlocked()
    }
    
    //MARK: - Methods
    
    private func setEnabled() {
        level2Button.isEnabled = UserDefaults.standard.bool(forKey: "isOn2")
        level3Button.isEnabled = UserDefaults.standard.bool(forKey: "isOn3")
        level4Button.isEnabled = UserDefaults.standard.bool(forKey: "isOn4")
        level5Button.isEnabled = UserDefaults.standard.bool(forKey: "isOn5")
        level6Button.isEnabled = UserDefaults.standard.bool(forKey: "isOn6")
        level7Button.isEnabled = UserDefaults.standard.bool(forKey: "isOn7")
    }
    
    private func checkUnlocked() {
        if UserDefaults.standard.bool(forKey: "Unlocked") == true {
            level6Button.isSelected = true
            level7Button.isSelected = true
        } else {
            level6Button.isSelected = false
            level7Button.isSelected = false
        }
    }
    
    private func alphaCheck() {
        sharedController.toggleButtonAlpha(with: level2Button)
        sharedController.toggleButtonAlpha(with: level3Button)
        sharedController.toggleButtonAlpha(with: level4Button)
        sharedController.toggleButtonAlpha(with: level5Button)
        sharedController.toggleButtonAlpha(with: level6Button)
        sharedController.toggleButtonAlpha(with: level7Button)
    }
    
    //MARK: - Actions
    
    @IBAction func level1ButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "Level1Segue", sender: self)
    }
    
    @IBAction func level2ButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "Level2Segue", sender: self)
    }
    
    @IBAction func level3ButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "Level3Segue", sender: self)
    }
    
    @IBAction func level4ButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "Level4Segue", sender: self)
    }
    
    @IBAction func level5ButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "Level5Segue", sender: self)
    }
    
    @IBAction func level6ButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "Level6Segue", sender: self)
    }
    
    @IBAction func level7ButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "Level7Segue", sender: self)
    }

}
