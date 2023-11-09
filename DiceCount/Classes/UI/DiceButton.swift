//
//  DiceButton.swift
//  DiceCount
//
//  Created by Roland Keesom on 07/03/2023.
//

import UIKit

class DiceButton: UIButton {
    private var delegate:DiceButtonDelegate? = nil
    var diceNumber = 1
    
    init(frame: CGRect, diceNumber: Int = 1, delegate: DiceButtonDelegate?) {
        super.init(frame: frame)
        
        self.delegate = delegate
        self.diceNumber = diceNumber
        
        setImage(UIImage(named: "dice\(diceNumber)"), for: .normal)
        setImage(UIImage(named: "dice\(diceNumber)")?.withTintColor(.link), for: .selected)
        
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonClicked() {
        delegate?.diceButtonClicked(diceNumber: diceNumber)
    }
}

protocol DiceButtonDelegate {
    func diceButtonClicked(diceNumber: Int)
}
