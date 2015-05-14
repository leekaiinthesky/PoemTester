//
//  ViewController.swift
//  PoemTester
//
//  Created by Lee-kai Wang on 5/14/15.
//  Copyright (c) 2015 Lee-kai Wang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var texts = PoemTexts()
    var poemTextLabel = UITextView()
    var loadButton = UIButton()
    var readButton = UIButton()
    var testButton = UIButton()
    
    var synth = AVSpeechSynthesizer()
    var chineseVoice = AVSpeechSynthesisVoice(language: "zh-TW")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        poemTextLabel.text = "\n".join(texts.pipaxing)
        //poemTextLabel.numberOfLines = 0
        poemTextLabel.editable = false
        poemTextLabel.textAlignment = NSTextAlignment.Center
        poemTextLabel.font = UIFont(name: poemTextLabel.font.fontName, size: 24)
        poemTextLabel.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height - 20 - 100)
        view.addSubview(poemTextLabel)
        
        loadButton.frame = CGRect(x: 0, y: view.frame.height - 100, width: view.frame.width / 3, height: 100)
        loadButton.backgroundColor = UIColor.redColor()
        loadButton.addTarget(self, action: "loadPoem:", forControlEvents: .TouchUpInside)
        loadButton.setTitle("See", forState: UIControlState.Normal)
        view.addSubview(loadButton)

        readButton.frame = CGRect(x: view.frame.width / 3, y: view.frame.height - 100, width: view.frame.width - (view.frame.width / 3) * 2, height: 100)
        readButton.backgroundColor = UIColor.greenColor()
        readButton.addTarget(self, action: "readPoem:", forControlEvents: .TouchUpInside)
        readButton.setTitle("Hear", forState: UIControlState.Normal)
        view.addSubview(readButton)

        testButton.frame = CGRect(x: view.frame.width - (view.frame.width / 3), y: view.frame.height - 100, width: view.frame.width / 3, height: 100)
        testButton.backgroundColor = UIColor.blueColor()
        testButton.addTarget(self, action: "testPoem:", forControlEvents: .TouchUpInside)
        testButton.setTitle("Test", forState: UIControlState.Normal)
        view.addSubview(testButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadPoem(sender: UIButton!) {
        view.addSubview(poemTextLabel)
    }

    func readPoem(sender: UIButton!) {
        view.addSubview(poemTextLabel)
        
        if !synth.speaking {
            for line in texts.pipaxing {
                var utterance = AVSpeechUtterance(string: line)
                utterance.rate = 0
                utterance.voice = chineseVoice
                utterance.postUtteranceDelay = 0.1
                synth.speakUtterance(utterance)
            }
        } else {
            synth.stopSpeakingAtBoundary(AVSpeechBoundary.Word)
        }
    }
    
    func testPoem(sender: UIButton!) {
        synth.stopSpeakingAtBoundary(AVSpeechBoundary.Word)
        poemTextLabel.removeFromSuperview()
    }
}

