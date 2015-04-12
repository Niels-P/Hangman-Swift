//
//  ViewController.swift
//  LearnSwift
//
//  Created by Niels Pijpers on 22-12-14.
//  Copyright (c) 2014 UB-online. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var word = "";
    var coins = 0;
    var gameState = 1;
    let labelFinal = UILabel(frame: CGRectMake(0, 310, 320, 50 ));
    var player : AVAudioPlayer! = nil // will be Optional, must supply initializer


    @IBOutlet weak var Galgjeimage: UIImageView!
    @IBOutlet var UIButt: [UIButton]!
    @IBOutlet weak var coinslabel: UILabel!

    @IBAction func skipWord(sender: AnyObject) {
        opgeven();
    }
    
    @IBAction func Alphatouched(sender: UIButton!) {
        var pressedButton = sender.currentTitle;
        
        if word.rangeOfString(String(pressedButton!)) != nil {
            var mix = "";
            var downie = String(labelFinal.text!);

            for(var d = 0; d < countElements(word); d++ ) {
                var idx = advance(word.startIndex, d);
                var idmmm = advance(downie.startIndex, d);
                println(idmmm);
                
                if(String(downie[idmmm]) == "*") {
                    if(String(word[idx]) == String(pressedButton!)) {
                        mix += String(word[idx]);
                    } else {
                        mix += "*";
                    }
                } else {
                    mix += String(downie[idmmm]);
                }
            }
            
            if mix.rangeOfString(String("*")) != nil {
                labelFinal.text = mix;
                sender.hidden = true;

            } else {
                let alert = UIAlertView()
                alert.title = "YEEEY!!! :)"
                alert.message = "Yeeey you found the word: \(mix)";
                alert.addButtonWithTitle("Again and again!")
                alert.show();
                sender.hidden = true;
                addCoins(50);
                
                let path = NSBundle.mainBundle().pathForResource("money2", ofType:"wav")
                let fileURL = NSURL(fileURLWithPath: path!)
                player = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
                player.prepareToPlay()
                player.play()
                
                restartGame();
            }
            
            
        } else {
            
            gameState++;
            sender.hidden = true;

            if(gameState != 7) {
                var imageView = UIImageView(frame: CGRectMake(100, 150, 150, 150));
                var image = UIImage(named: "\(gameState).gif");
                imageView.image = image;
                self.view.addSubview(imageView);
            
                let alert = UIAlertView()
                alert.title = "Wrong"
                alert.message = "The word does not contain the letter: \(String(pressedButton!))";
                alert.addButtonWithTitle("Oke.")
                alert.show();
            } else {
                let alert = UIAlertView()
                alert.title = "Dead"
                alert.message = "Sorry, you are dead. The word was: \(word).";
                alert.addButtonWithTitle("Try again!!")
                alert.show();
                restartGame();
                addCoins(-15);
                
            }
        }
    }
    
    func opgeven() {
        if(coins >= 50) {
            addCoins(-50);
            let alert = UIAlertView()
            alert.title = "Coins spended."
            alert.message = "You skipped the word, coins remaining: \(coins)";
            alert.addButtonWithTitle("Oke")
            alert.show();
            
            restartGame();
            
        } else {
            let alert = UIAlertView()
            alert.title = "Not enough."
            alert.message = "You don't have enough coins, jou need 50 coins and you have: \(coins) coins";
            alert.addButtonWithTitle("Oke")
            alert.show();
        }
    }
    
    func setCoins(amount: Int) {
        coins = amount;
        coinslabel.text = "\(coins)";
    }
    
    func addCoins(amount: Int) {
        coins = coins + amount;
        coinslabel.text = "\(coins)";
    }
    
    func restartGame() {
        gameState = 1;
        
        var imageView = UIImageView(frame: CGRectMake(100, 150, 150, 150));
        var image = UIImage(named: "1.gif");
        imageView.image = image;
        self.view.addSubview(imageView);
        selectWord();
        
        for(var c = 0; c < UIButt.count; c++) {
            UIButt[c].hidden = false;
        }
    }
    
    func createTiles(word: String) {
        var letterCount = countElements(word);
        labelFinal.textAlignment = NSTextAlignment.Center
        
        labelFinal.backgroundColor = UIColor.whiteColor()
        
        var sterretje = "";
        for(var i = 0; i < letterCount; i++) {
            sterretje += "*";
        }
        labelFinal.font = UIFont(name: "Verdana", size: 20);
        
        labelFinal.text = sterretje;
        
        labelFinal.tag = 5;
        
        self.view.addSubview(labelFinal);
        
    }
    
    
    
    
    func selectWord() {
        
        var words = ["GAAN", "GAT", "GEBEUREN", "GEBEURTENIS", "GEBIED", "GEBOORTE", "GEBOREN", "GEBRUIK", "GEBRUIKELIJK", "GEBRUIKEN", "GEDRAG", "GEDRAGEN", "GEEL", "GEEN", "GEHOORZAMEN", "GEIT", "GELD", "GELIEFDE", "GELIJK", "GELOOF", "GELUID", "GELUK", "GEMAK", "GEMAKKELIJK", "GEMEEN", "GENIETEN", "GENOEG", "GENOT", "GERECHT", "GEREEDSCHAP", "GESCHIKT"];
        var lower : UInt32 = 0
        var upper : UInt32 = UInt32(words.count);
        var randomNumber = arc4random_uniform(upper - lower) + lower
        
        word = words[Int(randomNumber)];
        print(word);
        createTiles(word);
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinslabel.text = "\(coins)";
        coinslabel.textColor = UIColor.yellowColor()
        coinslabel.shadowColor = UIColor.orangeColor()
        coinslabel.font = UIFont(name: "Verdana", size: 20);
        selectWord();
        var imageView = UIImageView(frame: CGRectMake(100, 150, 150, 150));
        var image = UIImage(named: "1.gif");
        imageView.image = image;
        self.view.addSubview(imageView);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

