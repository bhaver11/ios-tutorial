//
//  ViewController.swift
//  Dicee
//
//  Created by Synerg IITBombay on 07/04/20.
//

import UIKit

class ViewController: UIViewController {
    var numberOnDice1:Int = 0
    var numberOnDice2:Int = 0
    @IBOutlet weak var diceViewImage1: UIImageView!
    @IBOutlet weak var diceViewImage2: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        changeDiceFace()
        // Do any additional setup after loading the view.
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        changeDiceFace()
    }

    @IBAction func onRollClick(_ sender: UIButton) {
        changeDiceFace()
    }
    
    func changeDiceFace() {
        numberOnDice1 = Int.random(in: 1 ... 6)
        numberOnDice2 = Int.random(in: 1 ... 6)
        
        diceViewImage1.image = UIImage(named: "dice\(numberOnDice1)")
        diceViewImage2.image = UIImage(named: "dice\(numberOnDice2)")
        
    }
    
    
}

