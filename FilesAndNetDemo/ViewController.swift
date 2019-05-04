//
//  ViewController.swift
//  FilesAndNetDemo
//
//  Created by Alan Lam on 5/4/19.
//  Copyright © 2019 Alan Lam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var myProgressView: UIProgressView!
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Start up the activity indicator
        myActivityIndicator.startAnimating()
        
        // Start up Timer
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.handleSegmentedControl()
            self.handleProgressView()
            self.handleView()
        }
    }
    
    var indexCountUp = true
    var indexCount = 0
    func handleSegmentedControl() {
        mySegmentedControl.selectedSegmentIndex = indexCount
        if indexCountUp {
            indexCount += 1
            if indexCount == 3 {
                indexCount = 2
                indexCountUp = false
            }
        }
        else {
            indexCount -= 1
            if indexCount == -1 {
                indexCount = 0
                indexCountUp = true
            }
        }
    }
    
    var progressValue:Float = 0.0
    var progressValueUp = true
    func handleProgressView() {
        myProgressView.progress = progressValue
        if progressValueUp {
            progressValue += 0.1
            if progressValue >= 1.0 {
                progressValueUp = false
            }
        }
        else {
            progressValue -= 0.1
            if progressValue <= 0.0 {
                progressValueUp = true
            }
        }
    }
    
    var colorIndex = 0
    let colors = [UIColor.red, UIColor.green, UIColor.blue]
    func handleView() {
        myView.backgroundColor = colors[colorIndex]
        colorIndex += 1
        if colorIndex == colors.count {
            colorIndex = 0
        }
    }


}

