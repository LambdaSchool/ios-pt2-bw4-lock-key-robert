//
//  5ViewController.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 2/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit
import AVFoundation

class FiveViewController: UIViewController {

    //MARK: - Properties
    
    let sharedController = SharedController()
    var audioPlayer: AVAudioPlayer?
    
    //MARK: - Outlets
    
    @IBOutlet weak var level5Button: UIButton!
    @IBOutlet weak var keysButton: UIButton!
    
    @IBOutlet weak var bottomSwipeView: UIView!
    @IBOutlet weak var topSwipeView: UIView!
    @IBOutlet weak var middleSwipeView: UIView!
    
    @IBOutlet weak var topLeftHoldView: UIView!
    @IBOutlet weak var topRightHoldView: UIView!
    @IBOutlet weak var bottomRightHoldView: UIView!
    @IBOutlet weak var bottomLeftHoldView: UIView!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet var topLeftHoldRecognizer: UILongPressGestureRecognizer!
    @IBOutlet var topRightHoldRecognizer: UILongPressGestureRecognizer!
    @IBOutlet var bottomRightHoldRecognizer: UILongPressGestureRecognizer!
    @IBOutlet var bottomLeftHoldRecognizer: UILongPressGestureRecognizer!
    @IBOutlet var middleSwipeRecognizer: UISwipeGestureRecognizer!
    
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
        
        warningAlert()
    }
    
    //MARK: - Methods
    
    private func bordersOn() {
        sharedController.setupSwipeViewBorders(for: topSwipeView)
        sharedController.setupSwipeViewBorders(for: middleSwipeView)
        sharedController.setupSwipeViewBorders(for: bottomSwipeView)
        
        sharedController.setUpHoldViewBorders(for: topLeftHoldView)
        sharedController.setUpHoldViewBorders(for: topRightHoldView)
        sharedController.setUpHoldViewBorders(for: bottomRightHoldView)
        sharedController.setUpHoldViewBorders(for: bottomLeftHoldView)
        
        sharedController.setupButtonBorders(for: leftButton)
        sharedController.setupButtonBorders(for: rightButton)
    }
    
    private func gimmeShelter() {
        let gimmeShelter = Bundle.main.url(forResource: "GimmeShelter", withExtension: "mp3")!
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: gimmeShelter)
            audioPlayer?.play()
        } catch {
            print("Error Playing Gimme Shelter")
        }
    }
    
    private func stone() {
        let stone = Bundle.main.url(forResource: "Stone", withExtension: "mp3")!
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: stone)
            audioPlayer?.play()
        } catch {
            print("Error Playing Gimme Shelter")
        }
    }
    
    private func theseBoots() {
        let theseBoots = Bundle.main.url(forResource: "TheseBoots", withExtension: "mp3")!
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: theseBoots)
            audioPlayer?.play()
        } catch {
            print("Error Playing Gimme Shelter")
        }
    }
    
    private func fadeAway() {
        let fadeAway = Bundle.main.url(forResource: "FadeAway", withExtension: "mp3")!
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fadeAway)
            audioPlayer?.play()
        } catch {
            print("Error Playing Gimme Shelter")
        }
    }
    
    private func brandy() {
        let brandy = Bundle.main.url(forResource: "Brandy", withExtension: "mp3")!
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: brandy)
            audioPlayer?.play()
        } catch {
            print("Error Playing Gimme Shelter")
        }
    }
    
    private func warningAlert() {
        let warningAlert = UIAlertController(title: "This Level Includes Audio", message: "Please Turn Ringer On", preferredStyle: .alert)
        
        warningAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        if self.traitCollection.userInterfaceStyle == .dark {
            warningAlert.view.tintColor = .white
        } else {
            warningAlert.view.tintColor = .black
        }
        
        self.present(warningAlert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    
    @IBAction func level5ButtonTapped(_ sender: Any) {
        gimmeShelter()
        
        sharedController.addRiddleAlert(riddle: "'It's just a shot away'", answer: "gimme shelter", clue: "Hold for Three", viewController: self, button: nil, disableButton: nil, gesture: topLeftHoldRecognizer, disableGesture: nil, view: topLeftHoldView, segue: "openingSegue", audioPlayer: audioPlayer)
    }
    
    @IBAction func topLeftHoldComplete(_ sender: Any) {
        if topLeftHoldRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: topLeftHoldView)
            sharedController.fadeKeysIn(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.stone()
                
                self.sharedController.addRiddleAlert(riddle: "'The night is my companion & the highway is my home.'", answer: "stone", clue: "Hold for Three", viewController: self, button: nil, disableButton: self.level5Button, gesture: self.topRightHoldRecognizer, disableGesture: nil, view: self.topRightHoldView, segue: "openingSegue", audioPlayer: self.audioPlayer)
            })
        }
    }
    
    @IBAction func topRightHoldComplete(_ sender: Any) {
        if topRightHoldRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: topRightHoldView)
            sharedController.rotateKeysLeft(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.theseBoots()
                
                self.sharedController.addRiddleAlert(riddle: "'Like the time they hid that grass from those cops in Tupalo.'", answer: "these boots", clue: "Hold for Three", viewController: self, button: nil, disableButton: nil, gesture: self.bottomRightHoldRecognizer, disableGesture: self.topLeftHoldRecognizer, view: self.bottomRightHoldView, segue: "openingSegue", audioPlayer: self.audioPlayer)
            })
        }
    }
    
    @IBAction func bottomRightHoldComplete(_ sender: Any) {
        if bottomRightHoldRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: bottomRightHoldView)
            sharedController.rotateKeysDown(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.fadeAway()
                
                self.sharedController.addRiddleAlert(riddle: "'Here's a toast to your unknown... You and I are one together.'", answer: "fade away", clue: "Hold for Three", viewController: self, button: nil, disableButton: nil, gesture: self.bottomLeftHoldRecognizer, disableGesture: self.topRightHoldRecognizer, view: self.bottomLeftHoldView, segue: "openingSegue", audioPlayer: self.audioPlayer)
            })
        }
    }
    
    @IBAction func bottomLeftHoldComplete(_ sender: Any) {
        if bottomLeftHoldRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: bottomLeftHoldView)
            sharedController.rotateKeysRight(for: keysButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.brandy()
                
                self.sharedController.addRiddleAlert(riddle: "'He came on a summer's day bringin' gifts from far away.'", answer: "brandy", clue: "Swipe Right", viewController: self, button: nil, disableButton: nil, gesture: self.middleSwipeRecognizer, disableGesture: self.bottomRightHoldRecognizer, view: self.middleSwipeView, segue: "openingSegue", audioPlayer: self.audioPlayer)
            })
        }
    }
    
    @IBAction func middleSwipeComplete(_ sender: Any) {
        if middleSwipeRecognizer.state == .ended {
            sharedController.shadowOff(for: nil, or: middleSwipeView)
            sharedController.rotateKeysUp(for: keysButton)
            
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.sharedController.addLevel5TransitionRiddleAlert(riddle: "What is the theme of this level?", answer: "music", viewController: self, segue: "6Segue", level: "5", homeSegue: "openingSegue", disableButton: nil, disableGesture: self.bottomLeftHoldRecognizer)
                })
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        sharedController.fadeViewOut(view: self.view)
        
        sharedController.segueAfterFadeOut(viewController: self, segue: "openingSegue")
    }
}
