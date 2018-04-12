//
//  ViewController.swift
//  demo
//
//  Created by pikacode on 2018/4/11.
//  Copyright © 2018年 pikacode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var typewriterView: TypewriterView!
    @IBOutlet weak var button: UIButton!
    
    var count = 0
    
    @IBAction func btnAction(_ sender: Any) {
        
        var content = ""
        
        switch count {
        case 0:
            
            typewriterView.clear()
            content = "typewriterView.write(\"I start writing now!\")\n"
            + "=> I start writing now!\n\n"
            typewriterView.write(content)
            
        case 1:
            
            content = "typewriterView.write(\"I'm keep writing...\")\n"
            + "typewriterView.write(\"I'm writing 2\")\n"
            typewriterView.write(content)
            typewriterView.write("=> I'm keep writing...\n")
            typewriterView.write("=> I'm writing 2\n\n")
            
            button.setTitle("clear", for: .normal)
            
        case 2:
            
            
            content = "// now, clear!\n"
                + "typewriterView.clear()"
            typewriterView.write(content)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.typewriterView.clear()
            }
            
            button.setTitle("cursor blink", for: .normal)

        case 3:
            
            content = "typewriterView.write(\"I'm thinking...\")"
                + "typewriterView.cursorBlink()"
                + "typewriterView.write(\"I'm thinking again...\")"
                + "typewriterView.cursorBlink()"
            
            typewriterView.write("I'm thinking...")
            typewriterView.cursorBlink()
            typewriterView.write("\nI'm thinking again...")
            typewriterView.cursorBlink()
            typewriterView.write("\nI'm thinking again and again...")
            typewriterView.cursorBlink()
            typewriterView.cursorBlink()
            typewriterView.cursorBlink()
            
            count = 0
            button.setTitle("replay", for: .normal)
            
            break
        default:break
        }
        
        count = count + 1
    }
    
}

