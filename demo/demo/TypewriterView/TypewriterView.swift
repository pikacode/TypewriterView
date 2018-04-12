//
//  TypewriterView.swift
//  demo
//
//  Created by pikacode@qq.com on 2018/1/17.
//  Copyright © 2018年 pikacode. All rights reserved.
//

import UIKit

@IBDesignable class TypewriterView: UITextView {
    
    public func write(_ text: String) {
        tasks.append(.write(text))
        writeNext()
    }
    
    //clear and keep writing
    public func clear() {
        tasks.append(.clear)
        writeNext()
    }
    
    public func cursorBlink(){
        tasks.append(.cursorBlink)
        writeNext()
    }
    
    public func pause(){
        timer?.fireDate = Date.distantFuture
    }
    
    public func resume(){
        timer?.fireDate = Date()
    }
    
    //stop writing right now, and discard unwrite contents
    public func stop(){
        timer?.invalidate()
        timer = nil
        tasks.removeAll()
    }
    
    //discard unwrite contents, but keeps writing current text
    public func clearUnwriteContents(){
        tasks.removeAll()
    }
    
    public var writingSpeed = 0.02
    public var cursorBlinkRepeatTime = 4
    public var cursorBlinkSpeed = 0.4
    
    
    
    private var cursorBlinkRepeatTimeLast = 0
    
    private var tasks = [Task]()
    private var isPlaying : Bool { return timer != nil }
    
    private enum Task {
        case cursorBlink
        case clear
        case write(String)
        var text: String {
            switch self {
            case .write(let t):
                return t
            default:
                return ""
            }
        }
    }
    
    private func writeNext() {
        if isPlaying { return }
        if tasks.count == 0 { return }
        currerentTask = tasks.removeFirst()
        
        var selector: Selector
        var timeInterval = writingSpeed
        
        switch currerentTask {
        case .cursorBlink:
            selector = #selector(cursorBlinkSelector)
            cursorBlinkRepeatTimeLast = cursorBlinkRepeatTime
            timeInterval = 0.2
            
        case .clear:
            selector = #selector(clearSelector)
            
        case .write(let text):
            currerentText = text
            selector = #selector(writeSelector)

        }
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: selector, userInfo: nil, repeats: true)
        }
    }
    
    private var timer: Timer?
    
    private var currerentText = ""
    private var currerentTask = Task.write("")
    
    @objc private func writeSelector() {
        self.text = self.text?.appending(String(currerentText.removeFirst()))
        if currerentText.count == 0 {
            timer?.invalidate()
            timer = nil
            writeNext()
        }
    }
    
    @objc private func clearSelector() {
        self.text = ""
        timer?.invalidate()
        timer = nil
        writeNext()
    }
    
    @objc private func cursorBlinkSelector() {
        var temp = text ?? ""
        if let last = temp.last, last == "I" {
            temp = String(temp.dropLast())
        }else{
            temp.append("I")
        }
        text = temp
        cursorBlinkRepeatTimeLast = cursorBlinkRepeatTimeLast - 1
        if cursorBlinkRepeatTimeLast == 0 {
            timer?.invalidate()
            timer = nil
            writeNext()
        }
    }
    
}
 
