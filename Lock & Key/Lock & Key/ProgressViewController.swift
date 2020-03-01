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
    let openingVC = OpeningViewController()
    
    //MARK: - Outlets
    
    @IBOutlet weak var level2Label: UILabel!
    @IBOutlet weak var level3Label: UILabel!
    @IBOutlet weak var level4Label: UILabel!
    @IBOutlet weak var level5Label: UILabel!
    @IBOutlet weak var level6Label: UILabel!
    @IBOutlet weak var level7Label: UILabel!
    
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
        checkUnlocked()
        configureLabels()
        alphaCheck()
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
    
    private func configureLabels() {
        if level2Button.isEnabled {
            level2Label.text = "Unlocked"
            level2Label.textColor = .black
        }
        
        if level3Button.isEnabled {
            level3Label.text = "Unlocked"
            level3Label.textColor = .black
        }
        
        if level4Button.isEnabled {
            level4Label.text = "Unlocked"
            level4Label.textColor = .black
        }
        
        if level5Button.isEnabled {
            level5Label.text = "Unlocked"
            level5Label.textColor = .black
        }
        
        if level6Button.isEnabled {
            level6Label.text = "Unlocked"
            level6Label.textColor = .black
        }
        
        if level7Button.isEnabled {
            level7Label.text = "Unlocked"
            level7Label.textColor = .black
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
        openingVC.on1 = true
        self.dismiss(animated: true)
    }
    
    @IBAction func level2ButtonTapped(_ sender: Any) {
        openingVC.on2 = true
        self.dismiss(animated: true)
    }
    
    @IBAction func level3ButtonTapped(_ sender: Any) {
        openingVC.on3 = true
        self.dismiss(animated: true)
    }
    
    @IBAction func level4ButtonTapped(_ sender: Any) {
        openingVC.on4 = true
        self.dismiss(animated: true)
    }
    
    @IBAction func level5ButtonTapped(_ sender: Any) {
        openingVC.on5 = true
        self.dismiss(animated: true)
    }
    
    @IBAction func level6ButtonTapped(_ sender: Any) {
        openingVC.on6 = true
        self.dismiss(animated: true)
    }
    
    @IBAction func level7ButtonTapped(_ sender: Any) {
        openingVC.on7 = true
        self.dismiss(animated: true)
    }
}
