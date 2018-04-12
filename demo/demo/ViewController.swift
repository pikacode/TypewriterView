//
//  ViewController.swift
//  demo
//
//  Created by pikacode on 2018/4/11.
//  Copyright © 2018年 pikacode. All rights reserved.
//

import UIKit
import TypewriterView

class ViewController: UIViewController {

    @IBOutlet weak var typewriterView: TypewriterView!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func btnAction(_ sender: Any) {
        
        if !typewriterView.isFinished && !typewriterView.isPausing {
            typewriterView.pause()
            button.setTitle("Resume", for: .normal)
            return
        } else if !typewriterView.isFinished && typewriterView.isPausing {
            typewriterView.resume()
            button.setTitle("Pause", for: .normal)
            return
        }
        
        button.setTitle("Pause", for: .normal)
        
        typewriterView.completionBlock = { [weak self] in
            self?.button.setTitle("Replay", for: .normal)
        }
       
        typewriterView.clear()
        
        typewriterView.write("《Snow White》", speed: 0.2)
        typewriterView.write("\n\n")
        typewriterView.cursorBlink("⬜️", speed: 0.3, repeats: 5)
        
        typewriterView.write("Long long ago...\n", speed: 0.1)
        typewriterView.cursorBlink("I")
        
        typewriterView.write("There was 1️⃣ Queen and 9️⃣ Dwarfs.\n\n", speed: 0.005)
        typewriterView.cursorBlink()
        
        typewriterView.write("( Ouch!!! )")
        typewriterView.cursorBlink("🙀")
        typewriterView.undo(12, speed: 0.02)
        typewriterView.undo(5, speed: 0.08)
        typewriterView.undo(4, speed: 0.15)
        typewriterView.cursorBlink("❌")
        typewriterView.undo(5, speed: 0.3)
        
        typewriterView.cursorBlink()
        typewriterView.write("and 7️⃣ Dwarfs.\n\n", speed: 0.2)
        
        typewriterView.cursorBlink()
        typewriterView.write("The Queen was sitting at the window. There was snow outside in the garden--snow on the hill and in the lane, snow on the huts and on the trees: all things were white with snow.\n\n")
        
        typewriterView.cursorBlink()
        typewriterView.write("She had some cloth in her hand and a needle. The cloth in her hand was as white as the snow......")
        
    }
    
}

