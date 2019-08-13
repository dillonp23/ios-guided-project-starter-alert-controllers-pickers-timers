//
//  CountdownViewController.swift
//  Countdown
//
//  Created by Paul Solt on 5/8/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var countdownPicker: UIPickerView!
    
    // MARK: - Properties
    
    lazy private var countdownPickerData: [[String]] = {
        // Create string arrays using numbers wrapped in string values: ["0", "1", ... "60"]
        let minutes: [String] = Array(0...60).map { String($0) }
        let seconds: [String] = Array(0...59).map { String($0) }
        
        // "min" and "sec" are the unit labels
        let data: [[String]] = [minutes, ["min"], seconds, ["sec"]]
        return data
    }()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
//        let timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: timerFinished(_:))
        
        
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        
    }
    
    // MARK: - Private
    
    private func showAlert() {
        let alert = UIAlertController(title: "Timer Finished!", message: "Your countdown is over.", preferredStyle: .alert) // creating an alert controller
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil)) // adding an action... if you pass nil, tapping button will dismiss alert controller
        self.present(alert, animated: true) // now show the alert
        
    }
    
    private func updateViews() {
        
    }
    
    private func timerFinished(_ timer: Timer) {
        showAlert()
    }
    
    private func string(from duration: TimeInterval) -> String {
        #warning("return a string value derived from the time interval passed in")
        return ""
    }
}

extension CountdownViewController: CountdownDelegate {
    func countdownDidUpdate(timeRemaining: TimeInterval) {
        
    }
    
    func countdownDidFinish() {
        
    }
}

extension CountdownViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        #warning("Change this to return the number of components for the picker view")
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        #warning("Change this to return the number of rows per component in the picker view")
        return 0
    }
}

extension CountdownViewController: UIPickerViewDelegate {
    
}
