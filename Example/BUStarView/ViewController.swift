//
//  ViewController.swift
//  BUStarView
//
//  Created by vvlkv on 12/17/2018.
//  Copyright (c) 2018 vvlkv. All rights reserved.
//

import UIKit
import BUStarView

class ViewController: UIViewController {

    @IBOutlet weak var starView: BUStarView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func vertices(_ sender: UISlider) {
        starView.vertices = Int(sender.value)
    }
    
    @IBAction func outerRadius(_ sender: UISlider) {
        starView.outerRadius = CGFloat(sender.value)
    }
    @IBAction func outerRound(_ sender: UISlider) {
        starView.outerRound = CGFloat(sender.value)
    }
    @IBAction func innerRadius(_ sender: UISlider) {
        starView.innerRadius = CGFloat(sender.value)
    }
    @IBAction func innerRound(_ sender: UISlider) {
        starView.innerRound = CGFloat(sender.value)
    }
    @IBAction func fill(_ sender: UISwitch) {
        starView.fill = sender.isOn
    }
    @IBAction func color(_ sender: UISlider) {
        starView.fillColor = UIColor(red: CGFloat(redSlider.value),
                                       green: CGFloat(greenSlider!.value),
                                       blue: CGFloat(blueSlider!.value),
                                       alpha: 1.0)
    }
    
}

