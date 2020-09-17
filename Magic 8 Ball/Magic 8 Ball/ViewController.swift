//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Synerg IITBombay on 10/04/20.
//  Copyright © 2020 Synerg IITBombay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ballImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBallImage()
        // Do any additional setup after loading the view.
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        changeBallImage()
    }

    @IBAction func onAskClicked(_ sender: UIButton) {
        changeBallImage()
    }
    
    func changeBallImage() {
        let randomIndex = Int.random(in: 1 ... 5)
        ballImage.image = UIImage(named: "ball\(randomIndex)")
    }
    
}

