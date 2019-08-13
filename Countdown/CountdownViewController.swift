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
    @IBOutlet weak var stopButton: UIButton!
    
    
    // MARK: - Properties
    
    private let countdown = Countdown()
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SS" // capital 'S' is for milliseconds -> using 2 decimal point milliseconds here
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    private var duration: TimeInterval {
        let minuteString = countdownPicker.selectedRow(inComponent: 0)
        let secondsString = countdownPicker.selectedRow(inComponent: 2)
        
        let minutes = Int(minuteString)
        let seconds = Int(secondsString)
        
        let totalSeconds = TimeInterval((minutes * 60) + seconds)
        return totalSeconds
    }
    
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
    
        countdownPicker.dataSource = self
        countdownPicker.delegate = self
        
        countdownPicker.selectRow(1, inComponent: 0, animated: false)
        countdownPicker.selectRow(30, inComponent: 2, animated: false)
        
        countdown.duration = duration
        countdown.delegate = self
        
        // use a fixed width font for the time label
        timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeLabel.font.pointSize, weight: .medium)
        updateViews()
        stopButton.isHidden = true
        
    }
    
    // MARK: - Actions
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
//        let timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: timerFinished(_:))
      countdown.start()
    }
    
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        countdown.stop()
        startButton.isHidden = false
        stopButton.isHidden = true
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        countdown.reset()
        updateViews()
    }
    
    // MARK: - Private
    
    private func showAlert() {
        let alert = UIAlertController(title: "Timer Finished!", message: "Your countdown is over.", preferredStyle: .alert) // creating an alert controller
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil)) // adding an action... if you pass nil, tapping button will dismiss alert controller
        self.present(alert, animated: true) // now show the alert
        
    }
    
    private func updateViews() {
        
        switch countdown.state {
        case .started:
            timeLabel.text = string(from: countdown.timeRemaining)
            startButton.isEnabled = true
            countdownPicker.isUserInteractionEnabled = false
            startButton.isHidden = true
            stopButton.isHidden = false
        case .finished:
            timeLabel.text = string(from: 0)
            countdownPicker.isUserInteractionEnabled = true
            startButton.isHidden = false
            stopButton.isHidden = true
        case .reset:
            timeLabel.text = string(from: countdown.duration)
            countdownPicker.isUserInteractionEnabled = true
            startButton.isHidden = false
            stopButton.isHidden = true
        case .stopped:
            countdownPicker.isUserInteractionEnabled = true
            startButton.isHidden = false
            stopButton.isHidden = true
        }
    }
    
    private func timerFinished(_ timer: Timer) {
        showAlert()
    }
    
    private func string(from duration: TimeInterval) -> String {
        let date = Date(timeIntervalSinceReferenceDate: duration)
        return dateFormatter.string(from: date)
    }
}

extension CountdownViewController: CountdownDelegate {
    func countdownDidUpdate(timeRemaining: TimeInterval) {
        updateViews()
    }
    
    func countdownDidFinish() {
        updateViews()
        showAlert()
    }
}

extension CountdownViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return countdownPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countdownPickerData[component].count
    }
}

extension CountdownViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let timeValue = countdownPickerData[component][row]
        return timeValue
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countdown.duration = duration
        updateViews()
    }
}
