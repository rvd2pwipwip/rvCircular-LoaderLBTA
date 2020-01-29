//
//  ViewController.swift
//  rvCircularLoaderLBTA
//
//  Created by Herve Desrosiers on 2020-01-23.
//  Copyright © 2020 Herve Desrosiers. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    
    let shapeLayer = CAShapeLayer() // create layer
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
        
        // draw a circle
        // draw track layer
        let trackLayer = CAShapeLayer() // create layer
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true) // create bezier path
        trackLayer.path = circularPath.cgPath // set bezier path to layer path
        // set circle path attributes
        trackLayer.strokeColor = UIColor.red.withAlphaComponent(0.2).cgColor
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.position = view.center
        
        shapeLayer.path = circularPath.cgPath // set bezier path to layer path
        // set circle path attributes
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        shapeLayer.position = view.center
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1) //rotate 90 degress CCW aroud z axis
        
        view.layer.addSublayer(trackLayer)
        view.layer.addSublayer(shapeLayer)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
    
    let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
    
    private func beginDownloadingFile() {
        print("Attempting to download file")
        
        shapeLayer.strokeEnd = 0
        
        // execute url session to download file
        // let urlSession = URLSession.shared.dataTask(with: <#T##URL#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue() //background operation (download) not on main thread 
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        
        guard let url = URL(string: urlString) else { return }
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print(totalBytesWritten, totalBytesExpectedToWrite)
        
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite) * 100
        
        DispatchQueue.main.async { // update UI on main thread
            self.percentageLabel.text = "\(Int(percentage))%"
            self.shapeLayer.strokeEnd = percentage
        }
        
        print("\(Int(percentage))%")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finished downloading file")
    }
    
    fileprivate func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "")
    }
    
    @objc private func handleTap() {
        beginDownloadingFile()
//        animateCircle()
    }


}

