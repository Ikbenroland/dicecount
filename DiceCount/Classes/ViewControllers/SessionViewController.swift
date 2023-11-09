//
//  SessionViewController.swift
//  DiceCount
//
//  Created by Roland Keesom on 07/03/2023.
//

import UIKit

class SessionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var sessionTitle: String = ""
    var numberOfDices: Int = 0
    private var diceViews: [Int:DiceView] = [:]
    private var currentSession = Session()
    private var roundsData: [Int:Int] = [:]
    private var percentageSession = Session()
    private var percentageData: [Int:Int] = [:]
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var roundCountLabel: UILabel!
    @IBOutlet weak var calculationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("sessionTitle: \(sessionTitle) || count: \(numberOfDices)")
        
        for i in 0...numberOfDices-1 {
            let diceView = DiceView(frame: CGRect(x: 0, y: 100 + CGFloat(i*55), width: view.frame.size.width, height: 50))
//            diceView.delegate = self
            diceView.diceId = i
            view.addSubview(diceView)
            
            diceViews[i] = diceView
        }
        
        DispatchQueue.global(qos: .background).async {
            // Perform your background task here
            self.processCombinations()
            
            // Once the task is done, update the UI on the main thread
            DispatchQueue.main.async {
                // Update UI elements here
                self.updateData(reload: true)
            }
        }
        
        saveButton.frame.origin.y = 100 + CGFloat(numberOfDices*55)
        roundCountLabel.frame.origin.y = saveButton.frame.origin.y + 10
        calculationLabel.frame.origin.y = saveButton.frame.origin.y + 10
        
        collectionView.frame.origin.y = saveButton.frame.origin.y + 55
        collectionView.frame.size.height = view.frame.size.height - (collectionView.frame.origin.y+25)
        collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: "ResultCollectionViewCell")
        
        updateData(reload: false)
    }
    
    func processCombinations() {
        var diceArray: [[Int]] = []
        
        for _ in 1...numberOfDices {
            diceArray.append([1,2,3,4,5,6])
        }
        
        let combinations = loopCombinations(arrays: diceArray)
        for combination in combinations {
            percentageSession.addRound(.init(result: combination))
        }
//        print("percentageSession.roundsGroupedByNumber() - (\(percentageSession.roundsGroupedByNumber())/\(percentageSession.roundsCount())")
        percentageData = percentageSession.roundsGroupedByNumber()
    }
    
    func loopCombinationsHelper(arrayIndex: Int, selectedElements: [Int], results: inout [[Int]], arrays: [[Int]]) {
        if arrayIndex == arrays.count {
            results.append(selectedElements)
            let resultsCopy = results
            DispatchQueue.main.async {
                self.calculationLabel.text = "Calculating options: \(resultsCopy.count)"
            }
            return
        }
        for i in 0..<arrays[arrayIndex].count {
            var newSelectedElements = selectedElements
            newSelectedElements.append(arrays[arrayIndex][i])
            loopCombinationsHelper(arrayIndex: arrayIndex + 1, selectedElements: newSelectedElements, results: &results, arrays: arrays)
        }
    }

    func loopCombinations(arrays: [[Int]]) -> [[Int]] {
        var results = [[Int]]()
        loopCombinationsHelper(arrayIndex: 0, selectedElements: [], results: &results, arrays: arrays)
        return results
    }
    
    func updateData(reload: Bool) {
        print("updateData(reload: \(reload)")
        roundsData = currentSession.roundsGroupedByNumber()
        if reload {
            calculationLabel.text = ""
            collectionView.reloadData()
        }
        roundCountLabel.text = "Roll: \(currentSession.roundsCount())"
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        var diceNumbers: [Int] = []
        for (key, diceView) in diceViews {
//            print("\(key): \(diceView.selectedDiceNumber)")
            if diceView.selectedDiceNumber == nil {
                let alert = UIAlertController(title: "Error", message: "Not all dice selected", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        
        for (key, diceView) in diceViews {
            if let diceNumber = diceView.selectedDiceNumber {
                diceNumbers.append(diceNumber)
            }
            diceView.resetSelected()
        }
        
        currentSession.addRound(.init(result: diceNumbers))
        
        updateData(reload: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDices*6-(numberOfDices-1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCollectionViewCell", for: indexPath) as! ResultCollectionViewCell
        let number = numberOfDices+indexPath.row
        let count = roundsData[number] ?? 0
        
        var totalPercentageString = ""
        if percentageSession.roundsCount() > 0 {
            let totalPercentage = Int(round(Double(percentageData[number] ?? 0) / Double(percentageSession.roundsCount()) * 100.0))
            totalPercentageString = " - (avg. \(totalPercentage)%)"
        }
        
        let percentage = currentSession.roundsCount() == 0 ? 0 : Int(round(Double(count) / Double(currentSession.roundsCount()) * 100.0))
        
        cell.configure(with: "\(number) - \(count) (\(percentage)%)" + totalPercentageString)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 40)
    }
}
