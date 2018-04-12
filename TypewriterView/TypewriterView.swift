//
//  TypewriterView.swift
//  demo
//
//  Created by pikacode@qq.com on 2018/1/17.
//  Copyright © 2018年 pikacode. All rights reserved.
//

import UIKit

public class TypewriterView: UITextView {
    
    public var completionBlock = {}
    public var isFinished: Bool {
        return !(isPlaying || tasks.count > 0)
    }
    public var isPausing = false
    
    public func write(_ text: String, speed: TimeInterval = 0.02) {
        tasks.append(.write(text, speed))
        writeNext()
    }
    
    //clear and keep writing
    public func clear() {
        tasks.append(.clear)
        writeNext()
    }
    
    public func cursorBlink(_ character: Character = "I", speed: TimeInterval = 0.4, repeats: Int = 4){
        let rep = repeats%2 == 0 ? repeats : repeats + 1//必须是偶数次
        tasks.append(.cursorBlink(character, speed, rep))
        writeNext()
    }
    
    public func pause(){
        isPausing = true
        timer?.fireDate = Date.distantFuture
    }
    
    public func resume(){
        isPausing = false
        timer?.fireDate = Date()
    }
    
    //stop writing right now, and discard unwrite contents
    public func stop(){
        timer?.invalidate()
        timer = nil
        tasks.removeAll()
        completionBlock()
    }
    
    //discard unwrite contents, but keeps writing current text
    public func clearUnwriteContents(){
        tasks.removeAll()
    }
    
    public func undo(_ length: Int, speed: TimeInterval = 0.02){
        tasks.append(.undo(length, speed))
    }
    
    
    /********************************************************************/
    
    

    
    private var cursorBlinkRepeatTimeLast = 0
    private var tasks = [Task]()
    private var isPlaying : Bool { return timer != nil }
    private var undoLast = 0
    private var cursorBlinkCharacter: Character = "I"
    private var timer: Timer?
    private var currerentText = ""
    private var currerentTask = Task.write("", 0)
    
    private enum Task {
        case cursorBlink(Character, TimeInterval, Int)
        case clear
        case write(String, TimeInterval)
        case undo(Int, TimeInterval)
        var text: String {
            switch self {
            case .write(let t, _):
                return t
            default:
                return ""
            }
        }
    }
    
    private func writeNext() {
        if isPlaying { return }
        if tasks.count == 0 {
            completionBlock()
            return
        }
        currerentTask = tasks.removeFirst()
        
        var selector: Selector
        var timeInterval: TimeInterval = 0.02
        
        switch currerentTask {
        case .cursorBlink(let character, let speed, let repeats):

            cursorBlinkRepeatTimeLast = repeats
            timeInterval = speed
            cursorBlinkCharacter = character
            selector = #selector(cursorBlinkSelector)
            
        case .clear:
            
            selector = #selector(clearSelector)
            
        case .write(let text, let speed):
            
            currerentText = text
            timeInterval = speed
            selector = #selector(writeSelector)
            
        case .undo(let count, let speed):
            
            undoLast = count
            timeInterval = speed
            selector = #selector(undoSelector)
            
        }
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: selector, userInfo: nil, repeats: true)
        }
    }
    
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
        if let last = temp.last, last == cursorBlinkCharacter {
            temp = String(temp.dropLast())
        }else{
            temp.append(cursorBlinkCharacter)
        }
        text = temp
        cursorBlinkRepeatTimeLast = cursorBlinkRepeatTimeLast - 1
        if cursorBlinkRepeatTimeLast == 0 {
            timer?.invalidate()
            timer = nil
            writeNext()
        }
    }
    
    @objc private func undoSelector() {
        if undoLast > 0 && self.text.count > 0 {
            self.text.removeLast()
            undoLast = undoLast - 1
        } else {
            timer?.invalidate()
            timer = nil
            writeNext()
        }
    }
    
}


