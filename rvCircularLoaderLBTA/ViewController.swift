//
//  ViewController.swift
//  rvCircularLoaderLBTA
//
//  Created by Herve Desrosiers on 2020-01-23.
//  Copyright © 2020 Herve Desrosiers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let shapeLayer = CAShapeLayer() // create layer

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // draw a circle
        
        let center = view.center
        
        // draw track layer
        let trackLayer = CAShapeLayer() // create layer
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true) // create bezier path
        trackLayer.path = circularPath.cgPath // set bezier path to layer path
        // set circle path attributes
        trackLayer.strokeColor = UIColor.red.withAlphaComponent(0.2).cgColor
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.clear.cgColor
        
        shapeLayer.path = circularPath.cgPath // set bezier path to layer path
        // set circle path attributes
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(trackLayer)
        view.layer.addSublayer(shapeLayer)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
    
    @objc private func handleTap() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "")
    }


}

