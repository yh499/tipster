//
//  ViewController.swift
//  Tip
//
//  Created by Yukie Hirano on 11/3/17.
//  Copyright © 2017 Yukie Hirano. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //music
       var player:AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var decimalKey: UIButton!
    // calculated numbers
    @IBOutlet weak var minPercent: UILabel!

    @IBOutlet weak var minTip: UILabel!

    @IBOutlet weak var minEach: UILabel!
 
    // sliders
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var groupSlider: UISlider!
    @IBOutlet weak var groupSizeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //how you wanna show the display at the beggining:
         inputLabel.text = "0"
        
        do
        {
            let audioPath = Bundle.main.path(forResource: "y", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch
        {
            //PROCESS ERROR
        }
        let session = AVAudioSession.sharedInstance()
        
        do
        {
            try session.setCategory(AVAudioSessionCategoryPlayback)
        }
        catch
        {
        }
        
        player.play()
        snowDribbbleBalls(image: #imageLiteral(resourceName: "snow"))        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }

//animation-anow
//
    func snowDribbbleBalls(image: UIImage) {
        let _ = Emitter()

        let emitter = Emitter.get(with: image)
        emitter.emitterPosition = CGPoint(x: view.frame.width / 2, y:-50)
        emitter.emitterSize = CGSize(width: view.frame.width, height:2)
        view.layer.addSublayer(emitter)
    }
//
  
    @IBAction func keyPadPressed(_ sender: UIButton) {
        //when you are about to input new amount
        
        if inputLabel.text == "0" && sender.tag < 10 {
        
            inputLabel.text = String(sender.tag)
        // when you are already 0 and input "."
        
        } else if inputLabel.text == "0" && sender.tag == 12 {
        
            inputLabel.text = "0."
            
            sender.isEnabled = false
            // disabled button clicked-
            
        // when you keep adding input amounts
        } else if sender.tag < 10 {
            if let inputText = inputLabel.text {
                inputLabel.text = inputText + String(sender.tag)
            }
        } else if sender.tag == 11 {
            inputLabel.text = "0"
            sender.isEnabled = true
            //enabled the clicks
        } else if sender.tag == 12 {
            if let inputText = inputLabel.text {
                inputLabel.text = inputText + "."
                sender.isEnabled = false
                //disabled button so that there will be no more . after
            }
        }
        crunchNumbers()
        
    }
    
    @IBAction func tipSliderSlid(_ sender: Any) {
        minPercent.text = String(round(tipSlider.value)) + "%"
        crunchNumbers()
    }
    
    @IBAction func groupSliderSlid(_ sender: Any) {
        groupSizeLabel.text = String(Int(round(groupSlider.value)))
        crunchNumbers()
    }
    func crunchNumbers(){
        if let inputString = inputLabel.text {
            let input = Double(inputString)
            let tip = Double(round(tipSlider.value))
            let group = Double(round(groupSlider.value))
            let minimumTip = round((input! * (tip/100))*100)/100
            let minPerPerson = (round(((input! + minimumTip)/group)*100))/100

            minTip.text = String(minimumTip)
            minEach.text = String(minPerPerson)
        }
    }
    
    

}

