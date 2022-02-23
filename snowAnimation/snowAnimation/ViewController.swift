//
//  ViewController.swift
//  snowAnimation
//
//  Created by Elina Semenko on 16.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let sky = GradientView()
            sky.startColor = UIColor(red: 0.1, green: 0.25, blue: 0.5, alpha: 1)
            sky.endColor = UIColor(red: 0.75, green: 0.8, blue: 0.9, alpha: 1)
            sky.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(sky)

            NSLayoutConstraint.activate([
                sky.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                sky.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                sky.topAnchor.constraint(equalTo: view.topAnchor),
                sky.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        let snow = ParticleView()
        snow.particleImage = UIImage(named: "snowflake")
        snow.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(snow)
        NSLayoutConstraint.activate([snow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     snow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     snow.topAnchor.constraint(equalTo: view.topAnchor),
                                     snow.bottomAnchor.constraint(equalTo: view.bottomAnchor)])

    }
    
}

class GradientView: UIView {
    var startColor: UIColor = .clear
    var endColor: UIColor = .clear
    override class var layerClass: AnyClass { return CAGradientLayer.self}
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [startColor.cgColor, endColor.cgColor]
    }
}

class ShapeView: UIView {
    var strokeWidth: CGFloat = 2.0
    var strokeColor: UIColor = UIColor.black
    var fillColor: UIColor = UIColor.clear
    var path: UIBezierPath?

    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override func layoutSubviews() {
        let layer = self.layer as! CAShapeLayer

        // take a copy of our original path, because we're about to stretch it
        guard let pathCopy = path?.copy() as? UIBezierPath else { return }

        // create a transform that stretches the path by our width and height, and apply it to the copy
        pathCopy.apply(CGAffineTransform(scaleX: bounds.width, y: bounds.height))

        // apply all our properties to the shape layer
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        layer.lineWidth = strokeWidth
        layer.shadowColor = strokeColor.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
        layer.shadowOpacity = 1

        // convert the UIBezierPath to a CGPath and use it for the shape path
        layer.path = pathCopy.cgPath
    }
}
                               
class ParticleView: UIView {
    var particleImage: UIImage?
    var emitter = CAEmitterLayer()
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    func makeEmitterCell(color: UIColor, velocity: CGFloat, scale: CGFloat) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 10
        cell.lifetime = 20.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = velocity
        cell.velocityRange = velocity / 4
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 8
        cell.scale = scale
        cell.scaleRange = scale / 3

        cell.contents = particleImage?.cgImage
        return cell
    }
    
    override func layoutSubviews() {
        let emitter = self.layer as! CAEmitterLayer

        emitter.emitterShape = .line
        emitter.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        emitter.emitterSize = CGSize(width: bounds.size.width, height: 1)

        let near = makeEmitterCell(color: UIColor(white: 1, alpha: 1), velocity: 100, scale: 0.3)
        let middle = makeEmitterCell(color: UIColor(white: 1, alpha: 0.66), velocity: 80, scale: 0.2)
        let far = makeEmitterCell(color: UIColor(white: 1, alpha: 0.33), velocity: 60, scale: 0.1)

        emitter.emitterCells = [near, middle, far]
    }
}

