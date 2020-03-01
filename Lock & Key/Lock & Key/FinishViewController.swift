//
//  FinishViewController.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 2/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    //MARK: - Properties
    
    private let firework = Firework()
    let sharedController = SharedController()
    
    //MARK: - Outlets
    
    @IBOutlet weak var congratulationsLabel: UILabel!
    
    //MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        sharedController.fadeViewIn(view: self.view)
        giddyUp()
    }
    
    //MARK: - Methods
    
    private func setOffFirework() {
        firework.particleImage = UIImage(named: "circle")
        firework.flareImage = UIImage(named: "circle")
        firework.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firework)
        
        NSLayoutConstraint.activate([
            firework.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firework.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            firework.topAnchor.constraint(equalTo: view.topAnchor),
            firework.bottomAnchor.constraint(equalTo: congratulationsLabel.centerYAnchor)])
    }
    
    private func giddyUp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.setOffFirework()
            DispatchQueue.main.asyncAfter(deadline: .now() + 7.0, execute: {
                self.sharedController.fadeLabelInThenOut(label: self.congratulationsLabel, delay: 1.0)
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
                    self.performSegue(withIdentifier: "openingSegue", sender: self)
                })
            })
        })
    }
}
