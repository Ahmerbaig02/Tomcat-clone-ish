//
//  PlaySoundsViewController.swift
//  Chipmunk Project
//
//  Created by Thiago Costa on 1/27/16.
//  Copyright © 2016 Thiago Costa. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
  
    
    
    @IBAction func fastPlay(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 2.0
        audioPlayer.play()
        
    }
    
    
    @IBAction func snailPlaySound(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 0.5
        audioPlayer.play()
        
    }
    
    
    @IBAction func chipmunPlay(sender: AnyObject) {
        
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func darthVaderPlay(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
    
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    
    @IBAction func stopPlayingBtn(sender: AnyObject) {
        audioPlayer.stop()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        
        
        //
        //        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
        //
        //            let filePathUrl = NSURL.fileURLWithPath(filePath)
        //
        //
        //        }else {
        //
        //            print("The filePath does not exist")
        //        }
        //
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
