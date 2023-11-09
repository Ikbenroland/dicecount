//
//  DiceView.swift
//  DiceCount
//
//  Created by Roland Keesom on 07/03/2023.
//

import UIKit

class DiceView: UIView, DiceButtonDelegate {
    private var diceButtons: [DiceButton] = []
    var selectedDiceNumber: Int? = nil
    
//    var delegate:DiceViewDelegate? = nil
    var diceId:Int = 0
    
    required init(coder: NSCoder) { fatalError() }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        diceButtons = []
        for i in 1...6 {
            let button = DiceButton(frame: CGRect(x: i*50, y: 0, width: 50, height: 50), diceNumber: i, delegate: self)
            addSubview(button)
            diceButtons.append(button)
        }
    }
    
    func diceButtonClicked(diceNumber: Int) {
        selectedDiceNumber = diceNumber
        for button in diceButtons {
            if button.diceNumber == diceNumber {
                if button.isSelected {
                    selectedDiceNumber = nil
                    button.isSelected = false
                } else {
                    button.isSelected = true
                }
            } else {
                button.isSelected = false
            }
        }
//        delegate?.selectedDiceUpdated(diceNumber: selectedDiceNumber, diceId: diceId)
    }
    
    func resetSelected() {
        for button in diceButtons {
            button.isSelected = false
        }
        selectedDiceNumber = nil
    }
}

//protocol DiceViewDelegate {
//    func selectedDiceUpdated(diceNumber: Int?, diceId: Int)
//}
