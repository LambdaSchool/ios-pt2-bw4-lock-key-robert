//
//  Firework.swift
//  Lock & Key
//
//  Created by Bobby Keffury on 3/1/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation
import UIKit.UIView

class Firework: UIView {

    //MARK: - Properties
    
    var particleImage: UIImage?
    var flareImage: UIImage?
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    //MARK: - Methods
    
    func makeEmitterCellRocket() -> CAEmitterCell {
        
        let cell = CAEmitterCell()
        
        cell.emissionLongitude = -.pi/2
        cell.emissionLatitude = 0
        cell.emissionRange = 0
        cell.lifetime = 1.6
        cell.birthRate = 0.2
        
        cell.velocity = 50
        cell.velocityRange = cell.velocity/4
        cell.yAcceleration = -150
        
        cell.color = UIColor.black.cgColor
        
        cell.name = "Rocket"
        
        return cell
    }
    
    func makeEmitterCellFlare() -> CAEmitterCell {
        
        let cell = CAEmitterCell()
        cell.color = UIColor.white.cgColor
        cell.contents = flareImage?.cgImage
        
        cell.emissionLongitude = (2 * .pi)
        cell.birthRate = 30
        cell.lifetime = 10.0
        cell.velocity = 100
        cell.scale = 0.3
        
        cell.yAcceleration = 350
        
        cell.emissionRange = .pi/7
        cell.alphaSpeed = -0.7
        cell.scaleSpeed = -0.1
        cell.scaleRange = 0.1
        
        cell.beginTime = 0.01
        cell.duration = 2.0
        
        cell.name = "Flare"
        
        return cell
    }
    
    func makeEmitterCellFirework() -> CAEmitterCell {
        
        let cell = CAEmitterCell()
        
        cell.contents = particleImage?.cgImage
        cell.birthRate = 50000
        cell.velocity = 130
        cell.lifetime = 5.0
        cell.emissionRange = (2 * .pi)
        
        cell.scale = 0.1
        cell.alphaSpeed = -0.2
        cell.yAcceleration = 80
        
        cell.beginTime = 1.5
        cell.duration = 0.1
        cell.scaleSpeed = -0.015
        cell.spin = 2
        
        cell.name = "firework"
        return cell
    }
    
    func makeEmitterCellPrespark(for firework: CAEmitterCell) -> CAEmitterCell {
        
        let cell = CAEmitterCell()
        
        cell.birthRate = 80
        cell.velocity = firework.velocity * 0.70
        cell.lifetime = 1.2
        cell.yAcceleration = firework.yAcceleration * 0.85
        
        cell.beginTime = firework.beginTime - 0.2
        cell.emissionRange = firework.emissionRange
        cell.greenSpeed = 100
        cell.blueSpeed = 100
        cell.redSpeed = 100
        
        cell.name = "preSpark"
        
        return cell
    }
    
    func makeSparkle() -> CAEmitterCell {
        
        let cell = CAEmitterCell()
        
        cell.contents = particleImage?.cgImage
        
        cell.birthRate = 10
        cell.lifetime = 0.05
        cell.yAcceleration = 150
        
        cell.beginTime = 0.8
        cell.scale = 0.05
        
        return cell
    }
    
    override func layoutSubviews() {
        
        let emitter = self.layer as! CAEmitterLayer
        emitter.emitterPosition = CGPoint(x: bounds.midX, y: bounds.maxY)
        emitter.emitterSize = CGSize(width: bounds.size.width * 0.50, height: 1.0)
        emitter.renderMode = .additive
        
        let rocket = makeEmitterCellRocket()
        let flare = makeEmitterCellFlare()
        let firework = makeEmitterCellFirework()
        let sparkle = makeSparkle()
        let prespark = makeEmitterCellPrespark(for: firework)
        
        prespark.emitterCells = [sparkle]
        rocket.emitterCells = [flare, firework, prespark]
        emitter.emitterCells = [rocket]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            emitter.birthRate = 0
        }
        
    }
    
}
