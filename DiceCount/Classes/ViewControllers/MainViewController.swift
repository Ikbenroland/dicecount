//
//  MainViewController.swift
//  DiceCount
//
//  Created by Roland Keesom on 07/03/2023.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var diceCountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartSegue" {
            if let sessionVC = segue.destination as? SessionViewController {
                sessionVC.sessionTitle = titleTextField.text ?? "No title"
                sessionVC.numberOfDices = Int(diceCountTextField.text ?? "1") ?? 1
            }
        }
    }
}
